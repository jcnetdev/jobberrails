module Admin::CategoriesHelper
  def admin_category_nav_item(category)
    category_nav_item(category, true)
  end
  
  def show_save_category(category_id)
    "Element.show('saveCategory#{category_id}');Element.replace('messagesContainer', '<div id=\"messagesContainer\" style=\"display:none\">Value changed. You must save the change!</div>');Element.show('messagesContainer')"
  end
end
