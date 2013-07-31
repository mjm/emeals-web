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

  it "has a search field" do
    expect(page).to have_field "q"
    expect(page).to have_button "Search"
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
      expect(page).to have_selector "a .foundicon-edit"
    end

    it "displays a delete button" do
      expect(page).to have_selector "a .foundicon-trash"
    end

    it "displays a hide button" do
      expect(page).to have_selector "a .foundicon-minus"
    end
  end

  context "when there are more than 20 meals in the system" do
    before :each do
      30.times do |i|
        Meal.create!(entree: Dish.new(name: "Entree #{i+1}"),
                     side:   Dish.new(name: "Side #{i+1}"))
      end

      visit "/"
    end

    it "only displays the first 20 meals" do
      expect(page).to have_content "Entree 30"
      expect(all("#meals_list tr").size).to eq 20
    end

    it "displays a pagination bar" do
      expect(page).to have_selector "em", text: "1"
      expect(page).to have_selector "a", text: "2"
    end
  end
end

