class Meal < ActiveRecord::Base
  validates :entree, :side, presence: true

  belongs_to :entree, class_name: "Dish"
  belongs_to :side,   class_name: "Dish"

  def self.create_all_from_menu(menu)
    ImportMenuService.new.import(menu)
  end
end

