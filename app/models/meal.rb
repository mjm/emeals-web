class Meal < ActiveRecord::Base
  validates :entree, :side, presence: true
  validates :rating, numericality: {less_than: 6, greater_than_or_equal_to: 0}

  belongs_to :entree, class_name: "Dish"
  belongs_to :side,   class_name: "Dish"

  Flags = Emeals::Meal::FLAGS
end

