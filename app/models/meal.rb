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
    indexes :flags, as: Proc.new { flags.map(&:humanize) }
    indexes :entree_name, as: 'entree.name'
    indexes :side_name, as: 'side.name'
    indexes :entree_instructions, as: 'entree.instructions'
    indexes :side_instructions, as: 'side.instructions'
  end

  default_scope -> { order('created_at DESC').includes(:entree, :side) }
  scope :visible, -> { where(hidden_at: nil) }

  def self.search(query, page = nil)
    result_page = page || 1
    per_page = 20

    return visible.paginate(page: result_page, per_page: per_page) if query.blank?
    tire.search(query, load: {include: [:entree, :side]}, page: result_page, per_page: per_page)
  end

  def hide
    update hidden_at: Time.zone.now
  end
end

