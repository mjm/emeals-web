def fixture_menu_data
  meals = []

  meals << make_meal("Spicy Sausage Scramble", "Zucchini Casserole")
  meals << make_meal("Peppery Grilled Ribeye Steaks", "Heirloom Tomato and Spinach Salad")

  Struct.new(:count, :meals).new(2, meals)
end

def make_meal(entree_name, side_name)
  Emeals::Meal.new(make_dish(entree_name), make_dish(side_name))
end

def make_dish(name)
  Emeals::Dish.new(name)
end