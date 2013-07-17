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

  def rate
    meal.update rating: params[:rating]
    render nothing: true
  end

  protected

  def uploaded_menu
    params[:menu]
  end

  PERMITTED_MEAL_PARAMS = %w(
    entree_name side_name rating
    prep_hours prep_minutes
    cook_hours cook_minutes
    total_hours total_minutes
  )
  def meal_params
    params.require(:meal).permit(*PERMITTED_MEAL_PARAMS, flags: [])
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
    Meal.order('created_at desc').includes(:entree, :side)
  end
end
