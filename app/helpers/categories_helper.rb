module CategoriesHelper
  def category_nav_item(category)
    
    li_options = {}
    
    # see if we are displaying the currently selected category
    if category == @category
      li_options[:class] = "selected"
    end
    
    link = link_to "<span>#{category.name}</span><span class='cnr'>&nbsp;</span>", category_url(category), :title => category.name
    
    return content_tag(:li, link, li_options)
  end
end