class ImportMenuService
  def import(menu)
    menu = Emeals::Client.new.parse(menu)
    menu.meals.each do |meal|
      create_meal(meal)
    end
  end

  private

  def create_meal(meal)
    Meal.create(entree:      create_dish(meal.entree),
                side:        create_dish(meal.side),
                prep_time:   meal.times[:prep],
                cook_time:   meal.times[:cook],
                total_time:  meal.times[:total],
                flags:       meal.flags.map(&:to_s))
  end

  def create_dish(dish)
    Dish.create(name:         dish.name,
                instructions: dish.instructions.join("\n")).tap do |d|
      dish.ingredients.each do |i|
        d.ingredients.create(amount:      i.quantity.amount.to_s.sub("/1", ''),
                             unit:        i.quantity.unit.to_s,
                             description: i.description)
      end
    end
  end
end
