class Admin::CategoriesController < ApplicationController
  before_filter :login_required
  layout 'admin'
  
  # GET /admin/categories
  def index
    @categories = Category.all(:order => 'position ASC')
  end
  
  # GET /admin/categories/1
  def show
    @category = Category.find_by_value(params[:id])
    @jobs = @category.jobs.find_all_by_is_active(true, :order => "created_at DESC")
  end
  
  # POST /admin/categories
  def create
    temp = Category.find_by_sql "SELECT MAX(position) as position FROM categories" 
    @category = Category.new(:name => 'New category', :value => 'newcategory', :position => temp[0].position + 1)
    @category.save
    
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.js # admin/categories/create.js.rjs
    end
  end
  
  # PUT /admin/categories/1
  def update
    @category = Category.find(params[:id])
    
    respond_to do |format|
      if @category.update_attributes(:name => params[:name], :value => params[:url])
        format.html { redirect_to admin_categories_url }
        format.js # admin/categories/update.js.rjs
      end
    end
  end
  
  # PUT /admin/categories/saveorder
  def saveorder
    params[:categoriesContainer].each_with_index do |id, position|
      category = Category.find(id)
      category.update_attribute('position', position)
    end
    
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.js # admin/categories/saveorder.js.rjs
    end
  end
  
  # DELETE /admin/categories/1
  def destroy
    @category = Category.find(params[:id])
    @category.destroy if @category.jobs.empty?
    
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.js # admin/categories/destroy.js.rjs
    end
  end
end
