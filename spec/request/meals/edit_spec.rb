require 'spec_helper'

feature "Meal edit" do
  fixtures :meals, :dishes, :ingredients
  include RequestHelper

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

    it "hides ingredients that will be deleted", js: true do
      within ".recipe_content .entree" do
        expect(page).to have_selector 'input[value="beef stew meat"]'
        find(".delete a", match: :first).click
        expect(page).to have_no_selector 'input[value="beef stew meat"]'
      end
    end

    it "has a button to add ingredients" do
      within ".recipe_content .side" do
        expect(page).to have_button "Add Ingredient"
      end
    end

    describe "clicking the Add Ingredient button", js: true do
      describe "when there are no existing ingredients" do
        before :each do
          click_link "Side"
          click_button "Add Ingredient"
        end

        it "adds new ingredient fields in the appropriate place" do
          within ".recipe_content .side .ingredients" do
            expect(page).to have_field ingredient_field(:side, :amount, 0)
            expect(page).to have_field ingredient_field(:side, :unit, 0), visible: false
            expect(page).to have_field ingredient_field(:side, :description, 0)
          end
        end
      end

      describe "when there are existing ingredients" do
        before :each do
          click_link "Entree"
          click_button "Add Ingredient"
        end

        it "adds new ingredient fields in the appropriate place" do
          within ".recipe_content .entree .ingredients" do
            expect(page).to have_field ingredient_field(:entree, :amount, 3)
            expect(page).to have_field ingredient_field(:entree, :unit, 3), visible: false
            expect(page).to have_field ingredient_field(:entree, :description, 3)
          end
        end
      end
    end
  end

  context "when the form is submitted" do
    it "saves the entree name" do
      submit_meal_with { fill_in "Entree Name", with: "Better Entree" }
      expect(page).to have_content "Better Entree"
    end

    it "saves the side name" do
      submit_meal_with { fill_in "Side Name", with: "Better Side" }
      expect(page).to have_content "Better Side"
    end

    it "saves the rating" do
      submit_meal_with { fill_in "Rating", with: "4" }
      expect(page).to have_selector ".rateit[data-rateit-value='4']"
    end

    it "saves the flag changes" do
      submit_meal_with do
        check "Marinate Ahead"
        uncheck "Slow Cooker"
      end
      click_link "Delicious Entree"

      expect(page).to have_content "Marinate ahead"
      expect(page).to_not have_content "Slow cooker"
    end

    it "saves the time changes" do
      submit_meal_with do
        fill_in "meal[prep_minutes]", with: "45"
        fill_in "meal[total_hours]", with: "1"
        fill_in "meal[total_minutes]", with: "0"
      end
      click_link "Delicious Entree"

      expect(page).to have_selector ".prep_time", text: "45m"
      expect(page).to have_selector ".total_time", text: "1h"
    end

    it "saves the instructions" do
      submit_meal_with do
        within(".recipe_content .entree") { fill_in "Instructions", with: "Test instructions." }
        within(".recipe_content .side")   { fill_in "Instructions", with: "More test instructions." }
      end
      click_link "Delicious Entree"

      expect(page).to have_selector 'ol.instructions li', text: "Test instructions."
      expect(page).to have_selector 'ol.instructions li', text: "More test instructions."
    end

    it "saves existing ingredients that were edited in order" do
      submit_meal_with do
        within ".recipe_content .entree" do
          fill_in ingredient_field(:entree, :amount), with: "1/2"
          select "cup", from: ingredient_field(:entree, :unit)
          fill_in ingredient_field(:entree, :description), with: "beef broth"
        end
      end
      click_link "Delicious Entree"

      expect(page).to have_selector 'ul li.ingredient:first-child', text: "1/2 cup beef broth"
    end

    it "saves newly added ingredients", js: true do
      submit_meal_with do
        click_button "Add Ingredient"
        fill_in ingredient_field(:entree, :amount, 3), with: "1/2"
        select "cup", from: ingredient_field(:entree, :unit, 3), visible: false
        fill_in ingredient_field(:entree, :description, 3), with: "beef broth"
      end
      click_link "Delicious Entree"

      expect(page).to have_selector 'ul li.ingredient', text: "1/2 cup beef broth"
    end

    it "removes ingredients marked for deletion", js: true do
      submit_meal_with do
        within(".recipe_content .entree") do
          find(".delete a", match: :first).click
        end
      end
      click_link "Delicious Entree"

      expect(page).to have_content "1/2 teaspoon kosher salt"
      expect(page).to have_no_content "3/2 lb beef stew meat"
    end

    it "does not add blank ingredients", js: true do
      submit_meal_with do
        click_button "Add Ingredient"
      end
      click_link "Delicious Entree"

      expect(page).to have_content "1/2 teaspoon kosher salt"
      expect(all(".ingredient").size).to eq 3
    end
  end
end

