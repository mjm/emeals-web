require 'spec_helper'

feature "Meals list" do
  before :each do
    visit "/"
  end

  it "shows Meal Sorter in the title and header" do
    expect(page.title).to eq "Meal Sorter"
    expect(page).to have_selector "h1", text: "Meal Sorter"
  end

  it "shows a slogan in the header" do
    expect(page).to have_selector "h1 small", text: "A better way to use eMeals"
  end

  it "has a header" do
    expect(page).to have_selector "h2", text: "Your Saved Meals"
  end

  context "when there are no meals to list" do
    before :each do
      Meal.delete_all
      visit "/"
    end

    it "displays a message saying there are no meals" do
      expect(page).to have_content "You haven't uploaded any meals!"
    end
  end

  context "when there are some meals to list" do
    fixtures :meals, :dishes

    before :each do
      visit "/"
    end

    it "displays the name of the entree" do
      expect(page).to have_link "Delicious Entree"
    end

    it "displays the name of the side" do
      expect(page).to have_link "Delicious Side"
    end

    it "displays the rating" do
      expect(page).to have_selector ".rateit[data-rateit-value='2']"
    end

    it "displays an edit button" do
      expect(page).to have_button "Edit"
    end

    it "displays a delete button" do
      expect(page).to have_button "Delete"
    end
  end
end

