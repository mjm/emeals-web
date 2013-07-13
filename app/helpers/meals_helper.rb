module MealsHelper
  def show_flags(meal)
    meal.flags.map(&:humanize).join(", ")
  end

  def meal_flags
    Meal::Flags
  end

  def flag_field(desc, name)
    content_tag(:label, flag_check_box(name) + "\n" + desc)
  end

  def flag_check_box(name)
    check_box_tag("meal[flags][]", name, meal_form.flags.include?(name.to_s), id: "meal_flags_#{name}")
  end
end
