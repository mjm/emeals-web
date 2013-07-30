class Meal < ActiveRecord::Base
  include MealSearch

  default_scope -> { order('created_at DESC').includes(:entree, :side) }
  scope :visible, -> { where(hidden_at: nil) }

  validates :entree, :side, presence: true
  validates :rating, numericality: {less_than: 6, greater_than_or_equal_to: 0}

  belongs_to :entree, class_name: "Dish", autosave: true
  belongs_to :side,   class_name: "Dish", autosave: true

  Flags = Emeals::Meal::FLAGS

  def hide
    update hidden_at: Time.zone.now
  end
end

