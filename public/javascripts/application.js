// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
	initCalendar();
	//initIPList();
});

function initIPList() {
	$('.ip_list .ip').click(function() {
		if( $(this).hasClass('ip_selected') ) {
			$(this).removeClass('ip_selected');
			// gray out others
		}
		else {
			$(this).addClass('ip_selected');
			// gray out others
		}	
	});
	$('.ip_list .ip').mouseenter(function() {
		$(this).css('color','#FF0092');
		$(this).css('font-style','italic');
	});
	$('.ip_list .ip').mouseleave(function() {
		$(this).css('color','#000');
		$(this).css('font-style','normal');
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

