function proxy_picker_callback(){
  $("div[role='main'] .nginx,.apache").hide();
  $("."+$('#proxy_picker').val().toLowerCase()).show();
}
$('#proxy_picker').change(proxy_picker_callback);
$('#proxy_picker').change();
