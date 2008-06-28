# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def feed_links
    links_html = []
    
    # add category RSS feed
    if @category
      links_html << auto_discovery_link_tag(:atom, category_url(@category, :format => "atom"), :title => "Jobs for #{@category.name}")
    end

    # add site RSS feed
    links_html << auto_discovery_link_tag(:atom, jobs_url(:format => "atom"), :title => "All Jobs")
    
    # join html and return
    return links_html.join("\n")
  end
  
  def error_message_for(record, attribute, error_msg = nil)
    if record and record.respond_to? :errors
      error_list = [record.errors.on(attribute)].flatten
      return content_tag(:div, error_msg || error_list.join(", "), :class => "error-message")
    end
  end
  
end
