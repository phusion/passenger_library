$(document).ready(function() {
  $('#integration_mode_selector .nav a').click(function(e) {
    e.preventDefault();
    $(this).tab('show');
  });
});
