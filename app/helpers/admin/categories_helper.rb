module Admin::CategoriesHelper
  def admin_category_nav_item(category)
    category_nav_item(category, true)
  end
  
  def show_save_category(category)
    "Element.show('#{category.dom_id("save")}')"
  end
  
  def link_to_delete_category(category)
    link_to_remote(image_tag("icon-delete.png", :alt => 'Delete') + " Delete", {
      :url => admin_category_url(category.id), 
      :confirm => 'Are you sure you want to delete this category?', 
      :method => :delete,
      :loading => "showOverlay('#{category.dom_id}');",
      :complete => "Element.hide('overlay');" }, 
      { :class => 'deleteCategory'})
  end
  
  def link_to_save_category(category)
    link_to_remote(image_tag("disk.png", :alt => 'Save') + " Save", {
      :url => admin_category_url(category.id), 
      :method => :put, 
      :with => "'name='+$F('#{category.dom_id("name")}')+'&url='+$F('#{category.dom_id("url")}')",
      :loading => "showOverlay('#{category.dom_id}');",
      :complete => "Element.hide('overlay');" }, 
      { :id => "#{category.dom_id("save")}", 
        :class => 'saveCategory', :style => 'display:none;' })
  end
  
  def sortable_categories_container_options
    {:url => saveorder_admin_categories_path, 
      :tag => "div", 
      :handle => "categoryHandle",
      :loading => "showOverlay('categoriesContainer');",
      :complete => "Element.hide('overlay');"}      
  end
  
  def link_to_add_category
    link_to_remote image_tag("add.png", :alt => 'Add') + " Add new category", 
      :url => admin_categories_path, 
      :method => :post, 
      :loading => "Element.show('add-category-overlay')", 
      :complete => "Element.hide('add-category-overlay');"
  end
end
