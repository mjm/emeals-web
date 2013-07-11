require 'spec_helper'

describe ImportMenuService do
  before :each do
    [Meal, Dish, Ingredient].each {|klass| klass.destroy_all}
    client = double("client")
    allow(Emeals::Client).to receive(:new).and_return(client)
    allow(client).to receive(:parse).and_return(fixture_menu_data)
  end

  describe "#import" do
    it "creates each meal in the menu in the database" do
      subject.import("some_menu.pdf")
      expect(Meal.count).to be 2
    end

    describe "each created meal" do
      before :each do
        subject.import("some_menu.pdf")
        @meal = Meal.first
      end

      it "has an entree" do
        expect(@meal.entree.name).to eq "Spicy Sausage Scramble"
      end

      it "has a side" do
        expect(@meal.side.name).to eq "Zucchini Casserole"
      end

      it "has times" do
        %w(prep cook total).each do |time|
          expect(@meal.send("#{time}_time")).to be
        end
      end

      it "has flags" do
        expect(@meal.flags).to be
      end

      describe "ingredients" do
        it "has the correct number of ingredients" do
          expect(@meal.entree.ingredients.size).to eq 3
        end

        it "has the correct ingredient data" do
          ingredient = @meal.entree.ingredients.first
          expect(ingredient.amount).to eq "1"
          expect(ingredient.unit).to eq "tablespoon"
          expect(ingredient.description).to eq "ingredient 1"
        end
      end

      describe "instructions" do
        it "has the correct number of instructions" do
          expect(@meal.entree.instructions.split("\n").size).to eq 3
        end

        it "has the correct instructions" do
          expect(@meal.entree.instructions).to eq "Do thing #1\nDo thing #2\nDo thing #3"
        end
      end
    end

    # This is uncomfortably complicated for an example
    it "replaces identically-named meals" do
      pending "Reconsider how this should work"
      subject.import("some_menu.pdf")
      meal = double("meal")
      expect(Meal).to receive(:find_by).twice { meal }
      expect(meal).to receive(:destroy).twice
      expect(Meal).to receive(:create).twice
      subject.import("some_menu.pdf")
    end
  end
  
end
