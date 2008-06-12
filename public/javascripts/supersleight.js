var supersleight	= function() {
	
	var root = false;
	var applyPositioning = true;
	
	// Path to a transparent GIF image
	var shim			= '/images/x.gif';
	
	// RegExp to match above GIF image name
	var shim_pattern	= /x\.gif$/i;
	
	var fnLoadPngs = function() { 
	  $j("img").each(function(index) {
	   el_fnFixPng(this);	   
	  });
	  
	  $j("a,input").each(function(index) {
	    if(this.style.position === ''){
        this.style.position = 'relative';
      }
	  });	
	};
	
	var el_fnFixPng = function(img) {
		var src = img.src;
		img.style.width = img.width + "px";
		img.style.height = img.height + "px";
		img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='scale')";
		img.src = shim;
	};
	
	var addLoadEvent = function(func) {
		var oldonload = window.onload;
		if (typeof window.onload != 'function') {
			window.onload = func;
		} else {
			window.onload = function() {
				if (oldonload) {
					oldonload();
				}
				func();
			};
		}
	};
	
	return {
		init: function() { 
			addLoadEvent(fnLoadPngs);
		},
		
		limitTo: function(el) {
			root = el;
		},
		
		run: function() {
			fnLoadPngs();
		}
	};
}();

// limit to part of the page ... pass an ID to limitTo:
// supersleight.limitTo('header');

supersleight.init();