require 'spec_helper'

describe Ingredient do
  describe "associations" do
    it { should belong_to :dish }
  end
end
