module MealSearch
  extend ActiveSupport::Concern

  included do
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

    def self.search(query, page = nil)
      result_page = page || 1
      per_page = 20

      return visible.paginate(page: result_page, per_page: per_page) if query.blank?
      tire.search(query, load: {include: [:entree, :side]}, page: result_page, per_page: per_page)
    end
  end
end
