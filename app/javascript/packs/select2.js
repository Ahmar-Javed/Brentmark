import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$(document).on('turbolinks:load',function () {

  $('.js-searchable').select2 ({
    placeholder: "Select a Product",
    allowClear: true,   
  });

  $('.js-searchable-type').select2 ({
    placeholder: "Select a Discount Type",
    allowClear: true,   
  });

});
