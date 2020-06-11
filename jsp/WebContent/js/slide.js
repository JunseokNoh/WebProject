
	var didScroll; 
	var lastScrollTop = $(this).scrollTop(); 
	var delta = 5; 
	var navbarHeight = $('#quick_nav').outerHeight();

	var didScroll; 
	$(window).scroll(
		function(event){ 
			didScroll = true; 
	}); 
	
	setInterval(function() { 
	if (didScroll) {
		$('#quick_nav').addClass('nav-down');
		hasScrolled(); 
		didScroll = false; 
		} }, 250); 
			
	function hasScrolled() { 
		var st = $(this).scrollTop(); 
		if(Math.abs(lastScrollTop - st) <= delta) 
			return; 
		if (st > lastScrollTop && st > navbarHeight){ 
			$('#quick_nav').removeClass('nav-down').addClass('nav-up'); 
		} 
		else { 
			if(st + $(window).height() < $(document).height()) 
			{ 
				$('#quick_nav').removeClass('nav-up').addClass('nav-down'); 
			} 
		} 
		lastScrollTop = st;
	}