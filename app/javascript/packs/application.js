// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("jquery")
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'


$(document).on('turbolinks:load', function(event) {

  // auto vanish the notice
  setTimeout(function(){
    $('.PopupNotice').fadeOut("slow",function(){
      $(this).remove();
    })
  }, 4000);

  // filter transactions based on user
  $('.filter-select').change(function(event){
    var user = $('#filter-recipient').val();
    var status = $('#filter-status').val();
    $.ajax({
      type: "GET",
      url: "/transactions/filter_transaction",
      data:{
        user: user,
        status: status
      },
      success: function(response){
        // rendering js partial transaction/filter_transaction.js.erb
      }
    });
  });

  // update transaction status
  $('body').on('change', '.transaction-status', function(event) {
    var value = $(this).val();
    var id = $(this).closest('tr').data('transaction');
    $.ajax({
      type: "POST",
      url: "/transactions/update_status",
      data:{
        id: id,
        status: value
      },
      success: function(response){
        // rendering js partial transaction/filter_transaction.js.erb
      }
    });
  });


});
