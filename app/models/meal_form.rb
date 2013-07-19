require 'form'
require 'time_converter'

class MealForm < Form
  attr_reader :meal

  attribute :entree_name, String
  attribute :side_name, String
  attribute :flags, Array[String]
  attribute :rating, Integer

  %w(prep cook total).each do |time|
    attribute :"#{time}_hours", Integer
    attribute :"#{time}_minutes", Integer
  end

  attribute :entree_instructions, String
  attribute :side_instructions, String

  validates :entree_name, :side_name, presence: true
  validates :rating, numericality: {less_than: 6, greater_than_or_equal_to: 0}

  def initialize(meal = Meal.new)
    @meal = meal
    self.entree_name = @meal.entree.name
    self.side_name   = @meal.side.name
    self.flags       = @meal.flags
    self.rating      = @meal.rating

    self.prep_hours, self.prep_minutes   = split_time(@meal.prep_time)
    self.cook_hours, self.cook_minutes   = split_time(@meal.cook_time)
    self.total_hours, self.total_minutes = split_time(@meal.total_time)

    self.entree_instructions = @meal.entree.instructions
    self.side_instructions   = @meal.side.instructions
  end

  protected

  def persist!
    @meal.flags  = flags
    @meal.rating = rating
    %w(prep cook total).each do |time|
      @meal[:"#{time}_time"] = join_time(send("#{time}_hours"), send("#{time}_minutes"))
    end
    %w(entree side).each do |type|
      create_or_update_dish(type)
    end
    @meal.save
  end

  private

  def create_or_update_dish(type)
    if meal.new_record?
      meal.send("create_#{type}", self.send("#{type}_attributes"))
    else
      meal.send(type).update(self.send("#{type}_attributes"))
    end
  end

  def entree_attributes
    {name: entree_name, instructions: entree_instructions}
  end

  def side_attributes
    {name: side_name, instructions: side_instructions}
  end

  def split_time(time_string)
    TimeConverter.new.split(time_string)
  end

  def join_time(hours, minutes)
    TimeConverter.new.join(hours, minutes)
  end
end
