module MealsHelper
  class MealsFormBuilder < ActionView::Helpers::FormBuilder
    def unit_field(field = :unit)
      select field, Ingredient::Units, include_blank: true
    end

    def time_field(prefix, type)
      @template.content_tag(:div, number_field(:"#{prefix}_#{type}s"), class: "#{type}_field") +
        @template.content_tag(:div, @template.content_tag(:span, "#{type[0]}", class: 'postfix'), class: "#{type}_suffix")
    end

    def hours_field(prefix)
      time_field prefix, :hour
    end

    def minutes_field(prefix)
      time_field prefix, :minute
    end

    def time_fields(prefix)
      @template.content_tag(:div,
                            hours_field(prefix) +
                            minutes_field(prefix),
                            class: "time_fields")
    end

    def flag_fields
      Meal::Flags.map do |desc, name|
        flag_field desc, name
      end.join.html_safe
    end

    def flag_field(desc, name)
      @template.content_tag(:label,
                            @template.check_box_tag("meal[flags][]",
                                                    name,
                                                    @object.flags.include?(name.to_s),
                                                    id: "meal_flags_#{name}") \
                            + "\n" + desc)
    end
  end

  def show_flags(meal)
    meal.flags.map(&:humanize).join(", ")
  end

  def meal_form_for(record, *args, &block)
    options = args.extract_options!
    form_for(record, *(args << options.merge(builder: MealsFormBuilder, as: :meal)), &block)
  end
end
