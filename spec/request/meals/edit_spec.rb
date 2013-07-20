require 'spec_helper'

feature "Meal edit" do
  fixtures :meals, :dishes, :ingredients

  let(:meal) { meals(:delicious) }

  before :each do
    visit "/"
    click_button "Edit"
  end

  it "shows an 'Edit this Meal' header" do
    expect(page).to have_content "Edit this Meal"
  end

  it "populates fields for dish names" do
    expect(page).to have_field "Entree Name", with: "Delicious Entree"
    expect(page).to have_field "Side Name", with: "Delicious Side"
  end

  it "populates a field for the rating" do
    expect(page).to have_field "Rating", with: "2"
  end

  it "populates fields for flags" do
    expect(page).to have_checked_field "Slow Cooker"
    expect(page).to have_unchecked_field "On the Grill"
  end

  it "populates fields for times" do
    expect(page).to have_field "meal[prep_hours]", with: "0"
    expect(page).to have_field "meal[prep_minutes]", with: "10"
    expect(page).to have_field "meal[cook_minutes]", with: "15"
    expect(page).to have_field "meal[total_minutes]", with: "25"
  end

  def check_instructions(selector, text)
    within(".recipe_content #{selector}") do
      expect(page).to have_field "Instructions"
      contents = find_field("Instructions").value
      expect(contents).to match(text)
      expect(contents.split("\n").size).to eq 3
    end
  end

  it "populates the instruction field" do
    check_instructions(".entree", "Sprinkle beef evenly")
    check_instructions(".side", "Another set of instructions")
  end

  describe "ingredients" do
    it "populates description fields" do
      within ".recipe_content .entree" do
        expect(page).to have_selector 'input[value="beef stew meat"]'
        expect(page).to have_selector 'input[value="kosher salt"]'
        expect(page).to have_selector 'input[value="can diced tomatoes"]'
      end
    end

    it "populates quantity fields" do
      within ".recipe_content .entree" do
        expect(page).to have_selector 'input[value="3/2"]'
        expect(page).to have_selector 'input[value="14"]'
      end
    end

    it "populates unit fields" do
      within ".recipe_content .entree" do
        expect(page).to have_selector 'option[value=lb][selected=selected]'
        expect(page).to have_selector 'option[value=teaspoon][selected=selected]'
      end
    end
  end

  context "when the form is submitted" do
    before :each do
      fill_in "Entree Name", with: "Better Entree"
      fill_in "Side Name", with: "Better Side"
      check "Marinate Ahead"
      uncheck "Slow Cooker"
      fill_in "Rating", with: "4"
      fill_in "meal[prep_minutes]", with: "45"
      fill_in "meal[total_hours]", with: "1"
      fill_in "meal[total_minutes]", with: "0"
      within ".recipe_content .entree" do
        fill_in "Instructions", with: "Test instructions."
      end
      within ".recipe_content .side" do
        fill_in "Instructions", with: "More test instructions."
      end

      click_button "Save Meal Changes"
    end

    it "saves the entree name" do
      expect(page).to have_content "Better Entree"
    end

    it "saves the side name" do
      expect(page).to have_content "Better Side"
    end

    it "saves the rating" do
      expect(page).to have_selector ".rateit[data-rateit-value='4']"
    end

    it "saves the flag changes" do
      click_link "Better Entree"
      expect(page).to have_content "Marinate ahead"
      expect(page).to_not have_content "Slow cooker"
    end

    it "saves the time changes" do
      click_link "Better Entree"
      expect(page).to have_selector ".prep_time", text: "45m"
      expect(page).to have_selector ".total_time", text: "1h"
    end

    it "saves the instructions" do
      click_link "Better Entree"
      expect(page).to have_selector 'ol.instructions li', text: "Test instructions."
      expect(page).to have_selector 'ol.instructions li', text: "More test instructions."
    end
  end
end

