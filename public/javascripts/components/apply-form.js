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
    window.location.href = ''; 
    return false;
  });
  
  // 
  // $j("#apply_online_form").validate({
  //   rules: {
  //     job_applicant_name: { required: true },
  //     job_applicant_email: { required: true },
  //     job_applicant_message: { required: true }
  //   },
  //   messages: {
  //     job_applicant_name: ' <img src="{/literal}{$BASE_URL}{literal}img/icon-delete.png" alt="" />',
  //     job_applicant_email: ' <img src="{/literal}{$BASE_URL}{literal}img/icon-delete.png" alt="" />',
  //     job_applicant_message: ' <img src="{/literal}{$BASE_URL}{literal}img/icon-delete.png" alt="" />'
  //   }
  // });
  
});
