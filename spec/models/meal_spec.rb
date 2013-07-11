require 'spec_helper'

describe Meal do
  describe "validations" do
    it { should validate_presence_of :entree }
    it { should validate_presence_of :side }
  end

  describe "associations" do
    it { should belong_to :entree }
    it { should belong_to :side }
  end
end
