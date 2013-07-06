class Meal < ActiveRecord::Base
  validates :entree, :side, presence: true

  belongs_to :entree, class_name: "Dish"
  belongs_to :side, class_name: "Dish"

  def self.create_all_from_menu(menu)
    menu = Emeals::Client::new.parse(menu)
    menu.meals.each do |meal|
      entree = Dish.create(name: meal.entree.name)
      side   = Dish.create(name: meal.side.name)
      Meal.create(entree:      entree,
                  side:        side,
                  prep_time:   meal.times[:prep],
                  cook_time:   meal.times[:cook],
                  total_time:  meal.times[:total],
                  flags:       meal.flags.map(&:to_s))
    end
  end
end

