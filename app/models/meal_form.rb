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
  end

  protected

  def persist!
    @meal.flags  = flags
    @meal.rating = rating
    %w(prep cook total).each do |time|
      @meal[:"#{time}_time"] = join_time(send("#{time}_hours"), send("#{time}_minutes"))
    end
    if @meal.new_record?
      @meal.create_entree name: entree_name
      @meal.create_side   name: side_name
    else
      @meal.entree.update name: entree_name
      @meal.side.update   name: side_name
    end
    @meal.save
  end

  private

  def split_time(time_string)
    TimeConverter.new.split(time_string)
  end

  def join_time(hours, minutes)
    TimeConverter.new.join(hours, minutes)
  end
end
