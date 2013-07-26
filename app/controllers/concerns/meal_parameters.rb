module MealParameters
  def meal_params
    params.require(:meal).permit(permitted_meal_params)
  end

  def uploaded_menu
    params[:menu]
  end

  private

  def permitted_meal_params
    %w(
      rating id
      prep_hours prep_minutes
      cook_hours cook_minutes
      total_hours total_minutes
    ) + [{flags: [], entree_attributes: permitted_dish_params, side_attributes: permitted_dish_params}]
  end

  def permitted_dish_params
    [:name, :instructions, ingredients_attributes: permitted_ingredient_params]
  end

  def permitted_ingredient_params
    [:id, :amount, :unit, :description, :_destroy]
  end
end
