require 'spec_helper'

describe Meal do
  describe "validations" do
    it { should validate_presence_of :entree }
    it { should validate_presence_of :side }
    it { should validate_numericality_of(:rating).is_less_than(6).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should belong_to :entree }
    it { should belong_to :side }
  end

  describe "search" do
    describe "if a search query is provided" do
      let(:tire) { double(:tire, search: []) }
      let(:load_options) { {include: [:entree, :side]} }

      before do
        expect(Meal).to receive(:tire).and_return(tire)
        Meal.search('blah')
      end

      it "passes along the search query" do
        expect(tire).to have_received(:search).with('blah', anything)
      end

      it "tells Tire to load record with associations" do
        expect(tire).to have_received(:search).with(kind_of(String), load: load_options, page: 1, per_page: 20)
      end
    end

    describe "if a blank search query is provided" do
      let(:query) { Meal.search('').arel }

      it "loads the meals in order" do
        expect(query.orders.first.downcase).to eq 'created_at desc'
      end

      it "loads only visible meals" do
        expect(Meal.search('').to_sql).to include '"hidden_at" IS NULL'
      end
    end
  end

  describe "hiding" do
    fixtures :meals, :dishes

    let(:meal) { Meal.first }

    it "removes the meal from the visible scope" do
      meal.hide
      expect(Meal.visible).to_not include(meal)
    end
  end
end
