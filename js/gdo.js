$(document).ready(function(){
	gdoUpdateProgression();
	var refresh = setInterval(gdoUpdateProgression, 1500);
	$('.get-datas').on('click', function(){		
		autoRefresh();
	})
})

function autoRefresh(){
	$.getJSON('refresh', function(data){
		$('.response').html(fillTemplate(data));
		$('.testfade').fadeIn('slow');
	})
}

function fillTemplate(data){
	var source   = $("#programme-block-template").html();
	var template = Handlebars.compile(source);
	return template(data);
}

Handlebars.registerHelper('fstart', function(){
	return moment(this.start).format('HH:mm');
});
Handlebars.registerHelper('fend', function(){
	return moment(this.end).format('HH:mm');
});

function gdoGetProgression(start, end){
	var now = moment().format('x');
	var start = moment(start).format('x');
	var end = moment(end).format('x');

	var timeBetweenStartAndEnd = (end - start); 
	var timeBetweenStartAndToday = (now - start);

	var p = Math.round(timeBetweenStartAndToday / timeBetweenStartAndEnd * 100);

	p = (p >= 100)?100:p;
	p = (p < 0)?0:p;

	return p;
}

// function isRefreshRequired(p){
// 	if(p >= 100){
// 		forceAutoRefresh = true;
// 		return false;
// 	}else{
// 		$(this).css('width', p+'%');
// 	}
// 	if(forceAutoRefresh) autoRefresh();	
// }

function gdoUpdateProgression(){
	var forceAutoRefresh = false;
	$('.progress-bar').each(function() {
		var start = $(this).data('start');
		var end = $(this).data('end');
		var p = gdoGetProgression(start, end);
		$(this).css('width', p+'%');			
	});

	$('.time-color').each(function(){
		var start = $(this).data('start');
		var now = moment();		
		if(moment(start).isBefore(now))$(this).css('color', 'red');		
	});
}