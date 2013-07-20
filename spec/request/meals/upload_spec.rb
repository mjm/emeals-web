require 'spec_helper'

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

