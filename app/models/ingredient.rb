class Ingredient < ActiveRecord::Base
  default_scope -> { order(:id) }

  belongs_to :dish

  Units = Emeals::Quantity::UNITS
end
