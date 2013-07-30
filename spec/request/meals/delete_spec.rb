require 'spec_helper'

feature "Meal delete", js: true do
  fixtures :meals, :dishes

  def delete_meal
    visit "/"
    expect(page.driver.confirm_messages).to be_empty
    find("a[data-method=delete]:not([href*=hide])").click
    expect(page.driver.confirm_messages).to_not be_empty
  end

  context "when the user accepts the confirmation" do
    before :each do
      page.driver.accept_js_confirms!
      delete_meal
    end

    it "deletes the meal from the system" do
      visit "/"
      expect(page).to_not have_content "Delicious Entree"
    end
  end

  context "when the user declines the confirmation" do
    before :each do
      page.driver.dismiss_js_confirms!
      delete_meal
    end

    it "does not delete the meal from the system" do
      visit "/"
      expect(page).to have_content "Delicious Entree"
    end
  end
end

feature "Meal hide", js: true do
  fixtures :meals, :dishes

  context "when the user clicks the hide button" do
    before :each do
      visit "/"
      find("a[href*=hide]").click
    end

    it "no longer displays the meal" do
      expect(page).to have_content "You haven't uploaded any meals"
    end
  end
end
