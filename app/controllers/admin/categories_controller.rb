class Admin::CategoriesController < ApplicationController
  before_filter :login_required
  layout 'admin'
  
  # GET /admin/categories
  def index
    @categories = Category.list
  end
  
  # GET /admin/categories/1
  def show
    @category = Category.find_by_value(params[:id])
    @jobs = @category.jobs.find_all_by_is_active(true, :order => "created_at DESC")
  end
  
  # POST /admin/categories
  def create
    begin
      @category = Category.new(:name => 'New category', 
                               :value => "newcategory#{rand(Time.now)}")
      @category.save!
    rescue ActiveRecord::RecordInvalid
      retry
    end
    
    flash.now[:notice] = "Category has been added"
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
        flash.now[:notice] = "Category has been updated"
        format.html { redirect_to admin_categories_url }
        format.js # admin/categories/update.js.rjs
      else
        format.html { redirect_to admin_categories_url }
        format.js {
          render :update do |page|
            @category.reload            
            page.alert @category.errors.full_messages.join("\n")
            page.replace(@category.dom_id, :partial => 'admin/categories/category', :category => @category)
            page.sortable "categoriesContainer", sortable_categories_container_options
          end
        }
      end
    end
  end
  
  # PUT /admin/categories/saveorder
  def saveorder
    params[:categoriesContainer].each_with_index do |id, position|
      category = Category.find(id)
      category.update_attribute('position', position + 1)
    end
    flash.now[:notice] = "Categories order changed. Saving ..."
    
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.js # admin/categories/saveorder.js.rjs
    end
  end
  
  # DELETE /admin/categories/1
  def destroy
    @category = Category.find(params[:id])
    
    if @category.jobs.empty?
      @category.destroy 
      flash.now[:notice] = "Category has been deleted"
    end
    
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.js # admin/categories/destroy.js.rjs
    end
  end
end
