class Meal < ActiveRecord::Base
  validates :entree, :side, presence: true
  validates :rating, numericality: {less_than: 6, greater_than_or_equal_to: 0}

  belongs_to :entree, class_name: "Dish", autosave: true
  belongs_to :side,   class_name: "Dish", autosave: true

  Flags = Emeals::Meal::FLAGS

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, index: :not_analyzed
    indexes :entree_name, as: 'entree.name'
    indexes :side_name, as: 'side.name'
  end

  def self.search(query)
    tire.search(query, load: {include: [:entree, :side]})
  end
end

