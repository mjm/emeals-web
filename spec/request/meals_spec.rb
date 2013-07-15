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
      expect(page).to have_selector "form[enctype='multipart/form-data']"
      expect(page).to have_field "menu", type: "file"
    end

    it "has a button to upload the menu" do
      expect(page).to have_button upload_button
    end
  end

  it "uploads a menu and displays the saved meals" do
    attach_file "menu", "spec/fixtures/menu.pdf"
    click_button upload_button

    expect(page).to have_content "Spicy Sausage and Egg Scramble"
    expect(page).to have_content "Heirloom Tomato and Spinach Salad"
  end
end

feature "Meal show" do
  fixtures :meals, :dishes, :ingredients

  let(:entree_name) { "Delicious Entree" }
  let(:side_name)   { "Delicious Side" }

  before :each do
    visit "/"
    click_link entree_name
  end

  it "shows the entree name" do
    expect(page).to have_content entree_name
  end

  it "shows the side name" do
    expect(page).to have_content side_name
  end

  it "shows the meal times" do
    %w(10m 15m 25m).each {|time| expect(page).to have_content time }
  end

  it "shows any flags on the meal" do
    expect(page).to have_content "Slow cooker"
  end

  it "shows the ingredients of the meal" do
    within("ul .ingredient:first-child") do
      expect(page).to have_selector ".value", text: "3/2"
      expect(page).to have_selector ".type", text: "lb"
      expect(page).to have_content "beef stew meat"
    end
  end

  it "shows the instructions of the meal" do
    expect(page).to have_selector "ol.instructions li:first-child", text: "Sprinkle beef evenly with salt and pepper"
  end

  describe "ratings" do
    it "has a rating field" do
      expect(page).to have_field "Rating", type: "range", with: "2"
    end

    it "lets the user update the rating", js: true do
      fill_in "Rating", with: "3", visible: false
      page.execute_script "$('.rateit').click()"
      expect(page).to have_content "Rating saved"

      visit "/meals/#{meals(:delicious).id}"
      expect(page).to have_field "Rating", with: "3", visible: false
    end
  end
end

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
    expect(page).to have_field "Prep Time", with: "10m"
    expect(page).to have_field "Cook Time", with: "15m"
    expect(page).to have_field "Total Time", with: "25m"
  end

  context "when the form is submitted" do
    before :each do
      fill_in "Entree Name", with: "Better Entree"
      fill_in "Side Name", with: "Better Side"
      check "Marinate Ahead"
      uncheck "Slow Cooker"
      fill_in "Rating", with: "4"
      fill_in "Prep Time", with: "45m"
      fill_in "Total Time", with: "60m"

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
      expect(page).to have_selector ".prep_time", "45m"
      expect(page).to have_selector ".total_time", "60m"
    end
  end
end

feature "Meal delete" do
  fixtures :meals, :dishes

  before :each do
    visit "/"
    click_button "Delete"
  end

  it "deletes the meal from the system" do
    expect(page).to_not have_content "Delicious Entree"
  end
end
