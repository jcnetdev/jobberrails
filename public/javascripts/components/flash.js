$j(document).ready(function() {
  $j(".flash a.close-text").click(function() {
    $j(this).parents(".flash").fadeOut();
  });
});
