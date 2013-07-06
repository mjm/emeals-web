class AddDishesToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :entree_id, :integer
    add_column :meals, :side_id, :integer

    Meal.all.each do |meal|
      meal.create_entree(name: meal.entree_name)
      meal.create_side(name: meal.side_name)
      meal.save
    end

    remove_column :meals, :entree_name, :string
    remove_column :meals, :side_name, :string
  end
end
