// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require_tree .


$(document).ajaxComplete(function(event, xhr, settings){
    window.lastAutocompleteAdresses = JSON.parse(xhr.responseText);
});

$(document).ready(function(){
    $('#address_name').change(function() {
        var self = this;
        var currentAddress = window.lastAutocompleteAdresses.find(function(address) {
          return address.value == $(self).val();
        });
        if (currentAddress !== undefined){
            $('#address_lat').val(currentAddress.data[0]);
            $('#address_long').val(currentAddress.data[1]);
        }
    });    
})
