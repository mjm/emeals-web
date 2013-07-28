require 'spec_helper'

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
      page.execute_script "$('.rateit').trigger('rated')"
      expect(page).to have_content "Rating saved"

      visit "/meals/#{meals(:delicious).id}"
      expect(page).to have_field "Rating", with: "3", visible: false
    end
  end
end

