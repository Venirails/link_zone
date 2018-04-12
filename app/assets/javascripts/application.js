// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.atwho
//= require jquery_ujs
//= require bootstrap
//= require bindWithDelay
//= require moment.min
//= require fullcalendar.min
//= require jquery.datetimepicker

//= require private_pub
//= require chat
//= require_tree .

$(document).ready(function () {
  $("#event_event_datetime").datetimepicker({format: 'Y/m/d H:i'});
  $("#user_dob").datetimepicker({timepicker: false, format: 'Y/m/d', maxDate: '0'});
});
function get_authenticity_token(){
	return jQuery('meta[name="csrf-token"]').attr('content');
}
function mark_as_read(ids) {
	jQuery.ajax({
		
		type : 'get',
		url : '/home/mark_as_read',
		data : "&ids=" + ids + "&authenticity_token=" + get_authenticity_token()+"&format=js",
		asynchronous:true, 
		evalScripts:true
	});
}



function mark_as_seen(ids) {
	jQuery.ajax({
		
		type : 'get',
		url : '/home/mark_as_seen',
		data : "&ids=" + ids + "&authenticity_token=" + get_authenticity_token()+"&format=js",
		asynchronous:true, 
		evalScripts:true
	});
}

