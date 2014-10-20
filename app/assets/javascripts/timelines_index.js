$(document).ready(function(){
	$('.timeline').click(function(){
		var href = $(this).find('.title a').attr('href');
		window.location = href;
	});
});