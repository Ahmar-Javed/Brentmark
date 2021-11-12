import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$(document).ready(function(){
  // Turn on js-selectable class so that it becomes SELCT 2 tag
  $('.js-searchable').select2({
    placeholder: "Select a Product",
    allowClear: true,
    width: 200
    // If you are using Bootstrap, please add　`theme: "bootstrap"` too.
  });

   $('.js-searchable-type').select2({
    placeholder: "Select a Discount Type",
    allowClear: true,
    width: 200
    // If you are using Bootstrap, please add　`theme: "bootstrap"` too.
  });

});
