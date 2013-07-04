require 'spec_helper'

feature "Meals list" do
  before :each do
    visit "/"
  end

  it "shows Meal Sorter in the title" do
    expect(page.title).to eq "Meal Sorter"
  end

  it "has a header" do
    expect(page).to have_selector "h1", text: "Meals"
  end

  context "when there are no meals to list" do
    it "displays a message saying there are no meals" do
      expect(page).to have_content "You haven't uploaded any meals!"
    end
  end

  context "when there are some meals to list" do
    let(:entree_name) { "Delicious Entree" }
    let(:side_name)   { "Delicious Side" }

    before :each do
      Meal.create(entree_name: entree_name, side_name: side_name)
      visit "/"
    end

    it "displays the name of the entree" do
      expect(page).to have_content entree_name
    end

    it "displays the name of the side" do
      expect(page).to have_content side_name
    end
  end
end