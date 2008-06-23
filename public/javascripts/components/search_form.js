$j(document).ready(function()
{
  if($j("#search_form").notOnPage()){ return; }

  // setup search form progress bar
  $j('#indicator').ajaxStart(function() { 
    $j(this).show(); 
  }).ajaxStop(function() { 
    $j(this).hide(); 
  }); 
  
  // handle ajax search form
  $j("#search_form").ajaxForm({
    data: {ajax: "true"}, 
    target: "#search_results",
    success: function() {
      if($j("#search_form #keywords").val().length > 0)
      {
        $j(".page-content").hide();
        $j("#search_results").show();
      }
      else
      {
        $j("#search_results").hide();
        $j(".page-content").show();
      }
    }
  });
  
  // handle clearing search form and hiding results
  $j(".clear-search").livequery("click", function() {    
    $j("#search_form #keywords").val("");
    $j("#search_results").hide();
    $j(".page-content").show();
  });
  
  // perform keyword search
  $j("#search_form #keywords").bind("perform_search", function() {
    
    $this = $j(this);
    searchVal = $this.val();
    
    if(searchVal.length < 2 || searchVal == $this.attr("title"))
    {
      $j("#search_results").hide();
      $j(".page-content").show();
    }
    else
    {
      $j("#search_form").trigger("submit");
    }
  });
  
  // bind form for autosubmit  
  new Form.Element.Observer("keywords", 0.5, function() {
    $j("#search_form #keywords").trigger("perform_search");
  });
  
  // initialize search on page load
  $j("#search_form #keywords").trigger("perform_search");
  
});
