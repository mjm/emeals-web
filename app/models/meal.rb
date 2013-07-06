class Meal < ActiveRecord::Base
  validates :entree_name, :side_name, presence: true

  def self.create_all_from_menu(menu)
    menu = Emenus::Client.new.parse(menu)
    menu.meals.each do |meal|
      Meal.create(entree_name: meal.entree.name,
                  side_name:   meal.side.name,
                  prep_time:   meal.times[:prep],
                  cook_time:   meal.times[:cook],
                  total_time:  meal.times[:total],
                  flags:       meal.flags.map(&:to_s))
    end
  end
end

