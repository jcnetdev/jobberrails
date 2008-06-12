module JavascriptHelper
  
  # Add javascripts to page
  def javascripts(options = {})
    [
      javascript("prototype"), 
      javascript("scriptaculous/scriptaculous"),
      
      javascript("jquery"),
      javascript_tag("$j = jQuery.noConflict();"),
      javascript(include_javascripts("jquery.ext")),
      javascript(include_javascripts("libraries")),
      javascript(include_javascripts("common")),
      javascript(include_javascripts("components")),
      
      page_javascripts(options),
      javascript("application"),

      ie6_js
      
    ].flatten.join("\n")
  end
  
  # returns a list of *css file paths* for a sass directory
  def include_javascripts(path)
    if AppConfig.minimize
      "min/#{path}.js"
    else
      javascript_list = Dir["#{RAILS_ROOT}/public/javascripts/#{path}/*.js"]

      result = []
      javascript_list.each do |javascript|
        result << javascript.gsub("#{RAILS_ROOT}/public/javascripts/", "")
      end
  
      return result
    end
  end
  
  def ie6_js
    if browser_is? :ie6
      javascript("supersleight")
    end
  end
  
end