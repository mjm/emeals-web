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
end
