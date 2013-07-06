class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :amount
      t.string :unit
      t.string :description
      t.belongs_to :dish
      t.timestamps
    end
  end
end
