function proxy_picker_callback(){
  $("div[role='main'] .nginx,.apache").hide();
  $("."+$('#proxy_picker').val().toLowerCase()).show();
}
$('#proxy_picker').change(proxy_picker_callback);
$('#proxy_picker').change();

function meteor_picker_callback(){
  $("div[role='main'] .meteor").hide();
  $("."+$('.meteor_picker').val().toLowerCase()).show();
}
$('.meteor_picker').change(meteor_picker_callback);
$('.meteor_picker').change();
