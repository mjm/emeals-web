class AddHiddenMeals < ActiveRecord::Migration
  def change
    add_column :meals, :hidden_at, :datetime, default: nil
  end
end
