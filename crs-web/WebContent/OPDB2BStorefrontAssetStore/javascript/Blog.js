$(".blog-category").click(function() {
  $(".blog").hide();
  $(".blog." + $(this).attr('id')).show();
});

$(".allblogs").click(function() {
  $(".blog").show();
});