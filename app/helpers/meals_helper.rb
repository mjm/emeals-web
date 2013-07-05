module MealsHelper
  def show_flags(meal)
    meal.flags.map(&:humanize).join(", ")
  end
end
