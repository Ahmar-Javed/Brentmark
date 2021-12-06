$(document).on('turbolinks:load', function () {
  $(".my-select-box").on("change", function () {
    $.ajax({
        url: "/total_price",
        data: {
          qty: $(this).val(),
          id: $(this).attr("id")
        },
        type: "POST",
        error: function () {alert('error');},
        success: function (response) {
          $('.' + Object.keys(response)[0]).html(Object.values(response)[0] + '$');
          $('.cart-price').html(response.total_price + '$');
         }
    });
  });
});
