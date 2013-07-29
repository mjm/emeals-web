module RequestHelper
  def check_instructions(selector, text, count = 3)
    within(".recipe_content #{selector}") do
      expect(page).to have_field "Instructions"
      contents = find_field("Instructions").value
      expect(contents).to match(text)
      expect(contents.split("\n").size).to eq count
    end
  end

  def ingredient_field(type, field, index = 0)
    "meal[#{type}_attributes][ingredients_attributes][#{index}][#{field}]"
  end

  def edit_meal
    find("a[href*=edit]").click
  end

  def submit_meal_with(&block)
    visit "/"
    edit_meal
    instance_eval(&block)

    click_button "Save Meal Changes"
  end
end
