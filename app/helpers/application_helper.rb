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
  
end
