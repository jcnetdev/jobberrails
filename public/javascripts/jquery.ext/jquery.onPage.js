
// Returns whether or not a result set has results in it
jQuery.fn.onPage = function() { 
  return this.size() > 0;
} 

jQuery.fn.notOnPage = function() { 
  return this.size() == 0;
} 
