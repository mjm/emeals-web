class MealsController < ApplicationController
  def index
  end

  protected

  helper_method :meals

  def meals
    Meal.order('created_at desc')
  end
end
