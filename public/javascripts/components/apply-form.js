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
