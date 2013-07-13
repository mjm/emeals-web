require 'form'

class MealForm < Form
  attr_reader :meal

  attribute :entree_name, String
  attribute :side_name, String
  attribute :flags, Array[String]

  attribute :prep_time, String
  attribute :cook_time, String
  attribute :total_time, String

  validates :entree_name, :side_name, presence: true

  def initialize(meal = Meal.new)
    @meal = meal
    self.entree_name = @meal.entree.name
    self.side_name   = @meal.side.name
    self.flags       = @meal.flags
    self.prep_time   = @meal.prep_time
    self.cook_time   = @meal.cook_time
    self.total_time  = @meal.total_time
  end

  protected

  def persist!
    @meal.flags = flags
    if @meal.new_record?
      @meal.create_entree name: entree_name
      @meal.create_side   name: side_name
    else
      @meal.entree.update name: entree_name
      @meal.side.update   name: side_name
    end
    @meal.save
  end
end
