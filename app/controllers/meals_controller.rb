class MealsController < ApplicationController
  def index; end

  def show; end

  def upload
    Meal.create_all_from_menu(uploaded_menu)
    redirect_to root_url
  end

  protected

  def uploaded_menu
    params[:menu]
  end

  helper_method :meal
  def meal
    Meal.find(params[:id])
  end

  helper_method :meals
  def meals
    Meal.order('created_at desc')
  end
end
