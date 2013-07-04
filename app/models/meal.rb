class Meal < ActiveRecord::Base
  def self.create_all_from_menu(menu)
    menu = Emeals::Client.new.parse(menu)
    menu.meals.each do |meal|
      Meal.create(entree_name: meal.entree.name, side_name: meal.side.name)
    end
  end
end

