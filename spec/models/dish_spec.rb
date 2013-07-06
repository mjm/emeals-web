require 'spec_helper'

describe Dish do
  describe "associations"  do
    it { pending "maybe we don't need this."; should have_one :meal }
    it { should have_many :ingredients }
  end
end
