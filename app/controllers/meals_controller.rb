class MealsController < ApplicationController
  include MealParameters
  include ViewData

  data(:meal)      { Meal.find(params[:id]) }
  data(:meal_form) { MealForm.new(meal) }
  data(:meals)     { Meal.search(params[:q]) }

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
end
