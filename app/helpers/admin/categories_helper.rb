module Admin::CategoriesHelper
  def admin_category_nav_item(category)
    category_nav_item(category, true)
  end
  
  def show_save_category(category_id)
    "Element.show('saveCategory#{category_id}')"
  end
end
