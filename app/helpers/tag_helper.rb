module TagHelper
  def br
    "<br />"
  end

  def hr
    "<hr />"
  end
  
  def nbsp
    "&nbsp;"
  end

  def space
    "<hr class='space' />"
  end
  
  def anchor(anchor_name)
    "<a name='#{anchor_name}'></a>"
  end

  def clear(direction = nil)
    clear_tag(:div, direction)
  end
  
  def clear_tag(tag, direction = nil)
    "<#{tag} class=\"clear#{direction}\"></#{tag}>"
  end

  def bull
    "<li>&bull;</li>"
  end

  def lorem
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end
  
  def hidden
    {:style => "display:none"}
  end
  
  def hidden_if(condition)
    if condition
      {:style => "display:none"}
    else
      {}
    end
  end

  def add_class_if(condition, css_class)
    if condition
      {:class => css_class}
    else
      {}
    end
  end

  def clearbit_icon(icon, color, options = {})
    image_tag "clearbits/#{icon}.gif", {:class => "clearbits #{color}", :alt => icon}.merge(options)
  end
  
  def delete_link(*args)
    options = {:method => :delete, :confirm => "Are you sure you want to delete this?"}.merge(args.extract_options!)
    args << options
    link_to *args
  end
  
  def link_to_block(*args, &block)
    content = capture_haml(&block)
    return link_to(content, *args)
  end
  
  def link_to_image(image_path, label, url, options={})
    link_to(image_tag(image_path, :class => "vert-middle"), url, options)+
    "&nbsp;"+
    link_to(label, url, options)
  end

  def current_year
    Time.now.strftime("%Y")
  end
end