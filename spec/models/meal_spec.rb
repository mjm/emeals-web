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
      expect(tire).to have_received(:search).with(kind_of(String), load: load_options)
    end
  end
end
