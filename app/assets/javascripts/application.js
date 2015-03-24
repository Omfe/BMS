// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// = require jquery
// = require bootstrap-sprockets
// = require jquery_ujs
// = require twitter/bootstrap
// = require turbolinks
// = require_tree .
	$(function() {
	  $("#owners_search").keyup(function() {
	    $.get($("#owners_search").attr("action"), $("#owners_search").serialize(), null, "script");
	    return false;
	  });
  	  $("#beacons_search").keyup(function() {
  	    $.get($("#beacons_search").attr("action"), $("#beacons_search").serialize(), null, "script");
  	    return false;
  	  });
  	  $("#beacons th a, #beacons .pagination a").live("click", function() {
  	      $.getScript(this.href);
  	      return false;
  	    });
	  $("#owners th a, #owners .pagination a").live("click", function() {
	      $.getScript(this.href);
	      return false;
	    });
	});