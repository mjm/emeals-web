require 'spec_helper'

describe Meal do
  before :each do
    client = double("client")
    allow(Emeals::Client).to receive(:new).and_return(client)
    allow(client).to receive(:parse).and_return(fixture_menu_data)
  end

  describe "#create_all_from_menu" do
    it "creates each meal in the menu in the database" do
      expect(Meal).to receive(:create).twice
      Meal.create_all_from_menu("some_menu.pdf")
    end
  end
end
