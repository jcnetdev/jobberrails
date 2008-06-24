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