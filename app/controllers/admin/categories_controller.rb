class Admin::CategoriesController < ApplicationController
  before_filter :login_required
  layout 'admin'
  
  # GET /admin/jobs/1
  def show
    @category = Category.find_by_value(params[:id])
    @jobs = @category.jobs.find_all_by_is_active(true, :order => "created_at DESC")
  end
end
