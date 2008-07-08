module Admin::CategoriesHelper
  def admin_category_nav_item(category)
    category_nav_item(category, true)
  end
  
  def show_save_category(category_id)
    "Element.show('saveCategory#{category_id}')"
  end
  
  def link_to_delete_category(category_id)
    link_to_remote(image_tag("icon-delete.png", :alt => 'Delete') + " Delete", {
      :url => admin_category_url(category_id), 
      :confirm => 'Are you sure you want to delete this category?', 
      :method => :delete }, 
      { :class => 'deleteCategory'})
  end
  
  def link_to_save_category(category_id)
    link_to_remote(image_tag("disk.png", :alt => 'Save') + " Save", {
      :url => admin_category_url(category_id), 
      :method => :put, 
      :with => "'name='+$F('name[#{category_id}]')+'&url='+$F('url[#{category_id}]')" }, 
      { :id => "saveCategory#{category_id}", 
        :class => 'saveCategory', :style => 'display:none;' })
  end
  
  def sortable_element_categories_container
    sortable_element "categoriesContainer", 
      :url => saveorder_admin_categories_path, 
      :tag => "div", 
      :complete => visual_effect(:highlight, 'categoriesContainer')
  end
  
  def link_to_add_category
    link_to_remote image_tag("add.png", :alt => 'Add') + " Add new category", 
      :url => admin_categories_path, 
      :method => :post, 
      :loading => "Element.show('overlay')", 
      :complete => "Element.hide('overlay');"
  end
end
