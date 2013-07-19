class Dish < ActiveRecord::Base
  #has_one :meal
  has_many :ingredients

  def instructions_list
    return [] if instructions.blank?
    instructions.gsub("\r\n", "\n").gsub("\r", "\n").split("\n")
  end
end
