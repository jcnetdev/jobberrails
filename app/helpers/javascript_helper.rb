module JavascriptHelper
  
  # Add javascripts to page
  def javascripts(options = {})
    [
      framework_js,

      # recursively add javascript files from these folders 
      javascript_folder("jquery.ext"),
      javascript_folder("libraries"),
      javascript_folder("common"),
      javascript_folder("components"),
      
      page_javascripts(options),
      javascript("application"),
      
      ie6_js
      
    ].flatten.join("\n")
  end
  
  def framework_js
    [
      javascript("prototype"), 
      javascript("scriptaculous/scriptaculous"),
    
      javascript("jquery"),
      javascript_tag("$j = jQuery.noConflict();")
    ].flatten.join("\n")
  end  
  
  def ie6_js
    "<!--[if lt IE 7]>
      <script src='/javascripts/ie7.js' type='text/javascript></script>
    <![endif]-->"
  end
end