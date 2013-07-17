require 'spec_helper'
require 'time_converter'

describe TimeConverter do
  describe "#split" do
    it "splits times that are blank" do
      expect(subject.split('')).to eq [0, 0]
      expect(subject.split(nil)).to eq [0, 0]
    end

    it "splits times that are only minutes" do
      expect(subject.split('10m')).to eq [0, 10]
    end

    it "splits times that are only hours" do
      expect(subject.split('4h')).to eq [4, 0]
    end

    it "splits times that are hours and minutes" do
      expect(subject.split('4h 10m')).to eq [4, 10]
    end

    it "splits times that have hours and minutes with no space separators" do
      expect(subject.split('4h10m')).to eq [4, 10]
    end
  end

  describe "#join" do
    it "joins times that are blank" do
      expect(subject.join(0, 0)).to eq ""
    end

    it "joins times that are only minutes" do
      expect(subject.join(0, 15)).to eq "15m"
    end

    it "joins times that are only hours" do
      expect(subject.join(3, 0)).to eq "3h"
    end

    it "joins times that are hours and minutes" do
      expect(subject.join(3, 45)).to eq "3h 45m"
    end
  end
end
