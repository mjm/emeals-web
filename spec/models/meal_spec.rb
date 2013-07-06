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

    describe "each created meal" do
      before :each do
        allow(Meal).to receive(:create) do |params|
          @params = params
        end
        Meal.create_all_from_menu("some_menu.pdf")
      end

      it "has an entree name" do
        expect(@params).to have_key :entree_name
      end

      it "has a side name" do
        expect(@params).to have_key :side_name
      end

      it "has times" do
        %w(prep cook total).each do |time|
          expect(@params).to have_key "#{time}_time".to_sym
        end
      end

      it "has flags" do
        expect(@params).to have_key :flags
      end
    end

    # This is uncomfortably complicated for an example
    it "replaces identically-named meals" do
      Meal.create_all_from_menu("some_menu.pdf")
      meal = double("meal")
      expect(Meal).to receive(:find_by).twice { meal }
      expect(meal).to receive(:destroy).twice
      expect(Meal).to receive(:create).twice
      Meal.create_all_from_menu("some_menu.pdf")
    end
  end

  describe "validations" do
    it { should validate_presence_of :entree_name }
    it { should validate_presence_of :side_name }
  end
end
