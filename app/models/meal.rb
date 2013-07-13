class Meal < ActiveRecord::Base
  validates :entree, :side, presence: true

  belongs_to :entree, class_name: "Dish"
  belongs_to :side,   class_name: "Dish"

  Flags = Emeals::Meal::FLAGS
end

