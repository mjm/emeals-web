class AddRatings < ActiveRecord::Migration
  def change
    add_column :meals, :rating, :integer, default: 0
  end
end
