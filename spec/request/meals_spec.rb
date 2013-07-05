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

feature "Menu uploads" do
  let(:upload_button) { "Upload" }

  before :each do
    visit "/"
  end

  describe "upload form" do
    it "has a subheader for menu uploads" do
      expect(page).to have_selector "h3", text: "Upload a Menu"
    end

    it "has an upload field in a form" do
      expect(page).to have_selector "form[enctype='multipart/form-data'] input[type=file]"
    end

    it "has a button to upload the menu" do
      expect(page).to have_selector "input[type=submit][value=#{upload_button}]"
    end
  end

  it "uploads a menu and displays the saved meals" do
    attach_file "menu", "spec/fixtures/menu.pdf"
    click_button upload_button

    expect(page).to have_content "Spicy Sausage and Egg Scramble"
    expect(page).to have_content "Heirloom Tomato and Spinach Salad"
  end
end