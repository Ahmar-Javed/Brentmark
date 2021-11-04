$(document).ready(function () {
  $('#confirm').on('click', function (e) {
    if (confirm('are you sure you want to delete user')) {
      // do something
    } else {
      e.preventDefault();
    }
  });
});
