class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :entree_name
      t.string :side_name
      t.timestamps
    end
  end
end
