$j(document).ready(function() {
  if($j(".job-posts").notOnPage()){ return; }
  
  $j(".job-posts tr").mouseover(function() {$j(this).addClass("over");}).mouseout(function() {$j(this).removeClass("over");});
  $j(".job-posts tr:odd").addClass("alt");
});
