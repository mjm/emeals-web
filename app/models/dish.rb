class Dish < ActiveRecord::Base
  #has_one :meal
  has_many :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank

  def instructions_list
    return [] if instructions.blank?
    instructions.gsub("\r\n", "\n").gsub("\r", "\n").split("\n")
  end
end
