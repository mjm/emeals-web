class MealsController < ApplicationController
  def index; end

  def show; end

  def edit; end

  def update
    meal_form.attributes = meal_params.to_hash
    meal_form.save

    redirect_to root_url
  end

  def destroy
    meal.destroy
    redirect_to root_url
  end

  def upload
    ImportMenuService.new.import(uploaded_menu)
    redirect_to root_url
  end

  protected

  def uploaded_menu
    params[:menu]
  end

  def meal_params
    params.require(:meal).permit(:entree_name, :side_name, flags: [])
  end

  helper_method :meal
  def meal
    Meal.find(params[:id])
  end

  helper_method :meal_form
  def meal_form
    @meal_form ||= MealForm.new(meal)
  end

  helper_method :meals
  def meals
    Meal.order('created_at desc')
  end
end
