$(document).on('turbolinks:load', function () {
  var country = $('#country');
  var state = $('#state');

  $(country).on('change', function () {
    $.ajax({
      url: '/states',
      data: {
        country: country.val(),
      },
      type: 'get',
    });
  });

  $(state).on('change', function () {
    $.ajax({
      url: '/cities',
      data: {
        state: state.val(),
        country: country.val(),
      },
      type: 'GET',
    });
  });
});
