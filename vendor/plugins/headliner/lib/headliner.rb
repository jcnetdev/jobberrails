module Headliner
  
  def title(options, headline='')
    if options.is_a? String
      save_title(options, headline)
    else
      display_title(options)
    end
  end

  def save_title(title, headline)
    @title = title.gsub(/<\/?[^>]*>/, '')
    headline.blank? ? title : headline
  end

  def display_title(options)
    # Prefix (leading space)
    if options[:prefix]
      prefix = options[:prefix]
    elsif options[:prefix] == false
      prefix = ''
    else
      prefix = ' '
    end

    # Separator
    unless options[:separator].blank?
      separator = options[:separator]
    else
      separator = '|'
    end

    # Suffix (trailing space)
    if options[:suffix]
      suffix = options[:suffix]
    elsif options[:suffix] == false
      suffix = ''
    else
      suffix = ' '
    end
  
    # Lowercase title?
    if options[:lowercase] == true
      @title = @title.downcase unless @title.blank?
    end

    # Set website/page order
    unless @title.blank?
      if options[:reverse] == true
        # Reverse order => "Page : Website"
        return content_tag(:title, @title + prefix + separator + suffix + options[:site])
      else
        # Standard order => "Website : Page"
        return content_tag(:title, options[:site] + prefix + separator + suffix + @title)
      end
    end
    
    # If title is blank, return only website name
    content_tag :title, options[:site]
  end

  # Mr. T says, "Use my method, fool!"
  alias t title

end