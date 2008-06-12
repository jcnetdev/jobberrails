class CategoriesController < ApplicationController
  def index
    @categories = Category.find :all, :order => "position"
  end
  
  def show
    @category = current_category
  end
  
  protected
  def current_category
    @current_category ||= Category.find_by_value(params[:id])
    return @current_category
  end
end
