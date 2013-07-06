class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.text   :instructions
      t.timestamps
    end
  end
end
