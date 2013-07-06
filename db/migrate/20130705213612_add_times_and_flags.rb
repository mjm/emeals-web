class AddTimesAndFlags < ActiveRecord::Migration
  def change
    add_column :meals, :prep_time,  :string
    add_column :meals, :cook_time,  :string
    add_column :meals, :total_time, :string
    add_column :meals, :flags,      :string, array: true, default: []
  end
end
