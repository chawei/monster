// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
	initCalendar();
});

function initIPList() {
	$('.ip_list .ip').click(function() {
	  var img_domain = $(this).attr('rel');
	  
		if( $(this).hasClass('ip_selected') ) {
			$(this).removeClass('ip_selected');
			// gray out others
			$('.'+img_domain).animate({opacity: 1.0}, 600);
		}
		else {
			$(this).addClass('ip_selected');
			// gray out others
			$('.'+img_domain).animate({opacity: 0.5}, 600);
		}	
	});
}

function initCalendar() {
	// enable expand 
	$('.month .title').click(function() {
		var dates = $(this).parent().find('.dates_container');
		if( dates.hasClass('expanded') ) {
			dates.hide();
			dates.removeClass('expanded');
		} else {
			dates.show();
			dates.addClass('expanded');
		}			
	});
}

function insertNewBite() {
	
}

