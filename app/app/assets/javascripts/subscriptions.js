$(document).ready(function() {
  $('#jquery-cron').cron({
  	onChange: function() {
    	$('#subscription_cron').val($(this).cron("value"));
    }
  }); 
  
  	// Adding Quintly Profile IDs from checkboxes  
  	var collectQuintlyData = function(container, checkbox, input) {
  	 // gather list of checkboxes
  	  var checkboxes = $(container).find('input[type=checkbox]');
	  $(checkbox).on('click', function() {
	  	var quintlyIDs =[];
	  	checkboxes.each(function() {
	  		if ($(this).prop('checked') == true ) {
	  			quintlyIDs.push($(this).data('quintlyid'));
	  		};
	  	});
	  	$(input).val(function() {
	  		var str = '';
	  		for (var i=0; i<quintlyIDs.length; i++) {
	  			str = str+quintlyIDs[i]+',';
	  		}
	  		str = str.slice(0, - 1);
	  		return str;
	  	});
	  	console.log(quintlyIDs);
		});
	};
	collectQuintlyData('#quintly_profileid_checkboxes','input.quintly_profileid', '#subscription_quintly_worker_attributes_quintly_profileids');
});