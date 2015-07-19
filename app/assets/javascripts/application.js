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
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require bootstrap-tooltip
//= require autocomplete-rails
//= require bootstrap-timepicker
//= require_tree .

$(document).ready( function() {
 $('#example').dataTable();
 $('#myCarousel').carousel();
 $('.datepicker').datepicker({orientation: "auto",  "autoclose": true,format: 'mm-dd-yyyy'});
 $('.datepicker').datepicker("setDate",new Date());


 $("#shipment_packages").on('change', function() {
   var selVal = $(this).val();
   $("#pakage").html('');
   if(selVal > 0) {
     for(var i = 1; i<= selVal; i++) {
       $("#pakage").append('<div class="row-fluid dis"><div class="span4">'+i+'</div><div class="span4"><input type="number" name="packages_detail['+i+'[cod_value]]" class="span6" required = "required"></div><div class="span4" ><input type="number" name="packages_detail['+i+'[declare_value]]" class="span6" required = "required"></div></div>');
     }
   }
 });

 $("#create_shipment").click(function() {
   document.getElementById("address_recipient_address").value =  document.getElementById("address1").value + ";" + document.getElementById("address2").value
 });
 $("tr[data-link]").click(function() {
  window.location = $(this).data("link")
 });
} );
