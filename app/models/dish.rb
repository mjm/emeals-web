class Dish < ActiveRecord::Base
  #has_one :meal
  has_many :ingredients
end
