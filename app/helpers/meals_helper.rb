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

  def time_field(f, prefix, type)
    content_tag(:div, f.number_field(:"#{prefix}_#{type}s"), class: "#{type}_field") +
      content_tag(:div, content_tag(:span, "#{type[0]}", class: 'postfix'), class: "#{type}_suffix")
  end

  def hours_field(f, prefix)
    time_field f, prefix, :hour
  end

  def minutes_field(f, prefix)
    time_field f, prefix, :minute
  end

  def time_fields(f, prefix)
    content_tag(:div,
                hours_field(f, prefix) +
                minutes_field(f, prefix),
                class: "time_fields")
  end
end
