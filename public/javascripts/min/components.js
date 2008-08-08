/* ---- Compressing ./public/javascripts/components/apply-form.js ----- */
$j(document).ready(function() {
  if($j("#apply_online").notOnPage()){ return; }
  
  // expand form
  $j("#apply_online_now a").click(function() {
    
    $j('#apply_online').slideToggle("slow");
    $j('#apply_name').focus(); 
    window.location.href = '#apply'; 

    return false;
  });
  
  // hide form
  $j("#apply_online .cancel").click(function() {    
    $j('#apply_online').slideUp("slow"); 
    // window.location.href = ''; 
    return false;
  });
  
  
});

/* ---- Compressing ./public/javascripts/components/flash.js ----- */
$j(document).ready(function() {
  $j(".flash a.close-text").click(function() {
    $j(this).parents(".flash").fadeOut();
  });
});

/* ---- Compressing ./public/javascripts/components/job-posts.js ----- */
$j(document).ready(function() {
  if($j(".job-posts").notOnPage()){ return; }
  
  $j(".job-posts tr").mouseover(function() {$j(this).addClass("over");}).mouseout(function() {$j(this).removeClass("over");});
  $j(".job-posts tr:odd").addClass("alt");
});

/* ---- Compressing ./public/javascripts/components/publish_form.js ----- */
$j(document).ready(function()
{
  if($j("#publish_form").notOnPage()){ return; }
  
  if($j("#job_title").onPage())
  {
    $j('#title').focus();  
  }

  // if (BrowserDetect.browser != "Explorer")
  // {
  //   $j("#publish_form").validate({
  //     rules: {
  //       job_company: { required: true },
  //       job_title: { required: true },
  //       job_description: { required: true },
  //       job_poster_email: { required: true }
  //     }
  //   }); 
  // }
});

/* ---- Compressing ./public/javascripts/components/search_form.js ----- */
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

