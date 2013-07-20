class Ingredient < ActiveRecord::Base
  belongs_to :dish

  Units = Emeals::Quantity::UNITS
end
