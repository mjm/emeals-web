def fixture_menu_data
  meals = []

  meals << make_meal("Spicy Sausage Scramble", "Zucchini Casserole")
  meals << make_meal("Peppery Grilled Ribeye Steaks", "Heirloom Tomato and Spinach Salad")

  Struct.new(:count, :meals).new(2, meals)
end

def make_meal(entree_name, side_name)
  Emeals::Meal.new(make_dish(entree_name), make_dish(side_name)).tap do |meal|
    meal.times[:prep] = "15m"
    meal.times[:cook] = "30m"
    meal.times[:total] = "45m"
  end
end

def make_dish(name)
  Emeals::Dish.new(name).tap do |dish|
    3.times do |i|
      dish.ingredients << Emeals::Ingredient.new("#{i+1}",
                                                 :tablespoon,
                                                 "ingredient #{i+1}")
    end
  end
end
