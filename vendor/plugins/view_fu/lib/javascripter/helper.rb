module Javascripter
  module Helper

    # alias for javascript_include_tag
    def javascript(*input)
      input = [input].flatten
    
      javascript_include_tag(*input)
    end
    
    # Override this if needed
    def javascripts(options={})
      [
        # include the default sources (minus application.js)
        javascript(ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES),

        # include the dynamic page javascripts
        page_javascripts(options),

        # application.js always needs to be at the end
        javascript("application")
      ].join("\n")
    end
  
    # returns an entire directory of javascripts recursively
    def javascript_folder(path)
      if use_cache? 
        return javascript("min/#{path}.js")
      else
        result = []
        Dir["#{Rails.public_path}/javascripts/#{path}/**/*.js"].each do |item|
          result << item.gsub("#{Rails.public_path}/javascripts/", "")
        end
        return javascript(result)
      end
    end
  
    # Include Javascripts on the page 
    # options[:include] to an array of strings for javascripts to include
    # options[:exclude] sets an array of strings for javascripts to exclude
    # options[:cache] sets the cache option to javascript_include_tag (only for nonconditional items)
    #
    # Automatically includes javascripts (if they exist on filesystem)
    # - javascripts for [controller]/[controller].js and [controller]/[action].js
    #
    def page_javascripts(options={})
    
      # initialize collection
      javascripts = []
      conditional_scripts = []
      @javascripts_add ||= []
      @javascripts_ignore ||= []
    
      # Additional scripts (if requested)
      if options[:include]
        @javascripts_add = [options[:include]].flatten + @javascripts_add
      end
    
      # Exclude scripts (if requested)
      if options[:exclude]
        @javascripts_ignore = [options[:exclude]].flatten + @javascripts_ignore
      end

      # Add more scripts
      @javascripts_add.each do |javascript|
        javascripts << javascript
      end
    
      # Ignore scripts
      @javascripts_ignore.each do |javascript|
        javascripts.delete(javascript)
      end
    
      # dedup javascript array
      javascripts.uniq!
    
      # Build Output
      html_output = javascript_include_tag(*javascripts)
    
      # Controller/action scripts
      conditional_scripts << "#{controller.controller_name}"
      conditional_scripts << "#{controller.controller_name}/#{controller.action_name}"
      
      # only add conditional scripts if they exist on disk
      conditional_scripts.each do |javascript|
        if File.exist?("#{RAILS_ROOT}/public/javascripts/#{javascript}.js")
          html_output << "\n"
          html_output << javascript_include_tag(javascript)
        end
      end
    
      # return output
      return html_output
    end
  
    # add a javascript to the include list
    def add_javascript(*javascripts)
      @javascripts_add ||= []
      javascripts.each do |javascript|
        @javascripts_add << javascript
      end
    end
  
    # ignore a javascript
    def ignore_javascript(*javascripts)
      @javascripts_ignore ||= []
      javascripts.each do |javascript|
        @javascripts_ignore << javascript
      end
    end
  end
end