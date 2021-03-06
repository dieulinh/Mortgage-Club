// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require lodash
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap_datepicker

//= require admin/plugins/loaders/blockui.min.js
//= require admin/plugins/forms/selects/bootstrap_select.min
//= require admin/core/app
//= require admin/pages/form_bootstrap_select
//= require admin/plugins/forms/styling/switch.min
// Important to import jquery_ujs before bundle_AdminApp as that patches jquery xhr to use the authenticity token!

//= require build/bundle_AdminApp
