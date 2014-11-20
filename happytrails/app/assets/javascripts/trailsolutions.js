$('enter-starting-point').on('submit', function(e){
	var $form = $(this);

	$.ajax({
		url: '/trailsolutions',
		method: 'GET',
		dataType: 'JSON',
		success: function(data){
			console.log('yay');
		}
	});

});