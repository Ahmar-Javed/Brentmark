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
           location.reload();
         }
    });
});
});
