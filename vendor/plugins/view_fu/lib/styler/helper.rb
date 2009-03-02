module Styler
  module Helper
    # alias for stylesheet_link_tag
    def stylesheet(*input)
      input = [input].flatten
      stylesheet_link_tag(*input)
    end

    # override this in your application_helper to clean it up
    def stylesheets(options = {})
      [stylesheet("application"), page_stylesheets(options)].join("\n")
    end
    
    # returns an entire directory of stylesheets recursively
    def stylesheet_folder(path)
      if use_cache? # or browser_is? :ie
        return stylesheet("min/#{path}.css")
      else
        result = []
        Dir["#{Rails.public_path}/stylesheets/#{path}/**/*.css"].each do |css|
          result << css.gsub("#{Rails.public_path}/stylesheets/", "")
        end
        return stylesheet(result)
      end
    end
  
    # Include Stylesheets on the page 
    # options[:include] to an array of strings for stylesheets to include
    # options[:exclude] sets an array of strings for stylesheets to exclude
    #
    # Automatically includes stylesheets (if they exist on filesystem)
    # - stylesheets for [controller]/[controller].css and [controller]/[action].css
    # - stylesheets for browser overrides (ie6.css, ie7.css, safari.css)
    #
    def page_stylesheets(options={})

      # set default values
      stylesheets = []
      @stylesheets_add ||= []
      @stylesheets_ignore ||= []

      # Include sheets from options
      if options[:include]
        @stylesheets_add = [options[:include]].flatten + @stylesheets_add
      end
    
      # Exclude sheets from options
      if options[:exclude]
        @stylesheets_ignore = [options[:exclude]].flatten + @stylesheets_ignore
      end
    
      # Add all sheets from instance variable
      @stylesheets_add.each do |stylesheet|
        stylesheets << stylesheet
      end
    
      # Ignore all sheets from instance variable
      @stylesheets_ignore.each do |stylesheet|
        stylesheets.delete(stylesheet)
      end
    
      # dedupe stylesheets array
      stylesheets.uniq!
    
      # Build Initial Output
      html_output = stylesheet_link_tag(*stylesheets)
    
      # Build conditional stylesheets (we need to check these on the filesystem before including)
      conditional_stylesheets = []
    
      # Controller/action sheets
      conditional_stylesheets << "pages/#{controller.controller_name}"
      conditional_stylesheets << "pages/#{controller.controller_name}/#{controller.action_name}"
        
      # IE6
      if browser_is?(:ie6)
        conditional_stylesheets << "ie6"
      end
    
      # IE7
      if browser_is?(:ie7)
        conditional_stylesheets << "ie7"
      end
  
      # Safari
      if browser_is?(:safari) and 
        conditional_stylesheets << "safari"
      end  
    
      # only add conditional stylesheets if they exist on disk
      conditional_stylesheets.each do |stylesheet|
        if File.exist?("#{RAILS_ROOT}/public/stylesheets/#{stylesheet}.css")
          html_output << "\n"
          html_output << stylesheet_link_tag(stylesheet)
        end
      end        
    
      return html_output
    end
  
    # Allows individual views to customize the stylesheet list
    def add_stylesheet(*stylesheets)
      @stylesheets_add ||= []
      stylesheets.each do |stylesheet|
        @stylesheets_add << stylesheet
      end
    end
  
    # Allows individual views to customize the stylesheet list
    def ignore_stylesheet(*stylesheets)
      @stylesheets_ignore ||= []
      stylesheets.each do |stylesheet|
        @stylesheets_ignore << stylesheet
      end
    end
  end
end