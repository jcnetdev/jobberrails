module CategoriesHelper
  def category_nav_item(category, admin = false)
    
    li_options = {}
    
    # see if we are displaying the currently selected category
    if category == @category
      li_options[:class] = "selected"
    end
    
    link = link_to "<span>#{category.name.pluralize}</span><span class='cnr'>&nbsp;</span>", (admin ? admin_category_url(category) : category_url(category)), :title => category.name.pluralize
    
    return content_tag(:li, link, li_options)
  end
end