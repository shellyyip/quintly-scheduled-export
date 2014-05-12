$(document).ready(function() {
  $('#jquery-cron').cron({
  	onChange: function() {
    	$('#subscription_cron').val($(this).cron("value"));
    }
  }); 
});