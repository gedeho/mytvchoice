var refreshPage;
var refreshDelay;

$(document).ready(function(){
	gdoUpdateProgression();
	var refreshProgress = setInterval(gdoUpdateProgression, 1500);
	refreshPage = setInterval(isRefreshRequired, 2000)
	$('.get-datas').on('click', function(){		
		autoRefresh();
	})

	$('.get-soonFinished').on('click', function(){		
		getSoonFinished();
	})

	$('.get-soonStarted').on('click', function(){		
		getSoonStarted();
	})
})

function getSoonFinished(){
	var finishIn = $('#startIn').val();
	console.log(finishIn)
	$.getJSON('getSoonFinished',
	{a:finishIn}).done(function(data){
		console.log(data);
		$('.response').html(fillTemplate(data));
	})
}

function getSoonStarted(){
	var startIn = $('#startIn').val();
	console.log(startIn)
	$.getJSON('getSoonStarted',
	{a:startIn}).done(function(data){
		console.log(data);
		$('.response').html(fillTemplate(data));
	})
}


// '2017-07-02 17:15:00'
function isRefreshRequired(){
	$('.programme-block-container').each(function(){
		var item = $(this);		
		var end = item.data('end');
		var now = moment();
		if(moment(now).isAfter(end)){
			console.log('Programme '+item.data('name')+' terminé ('+end+')');
			item.fadeOut('slow', function(){
				getNewBlock(item);
				item.remove();
			});			
			return false
		} 
	})	 
}

function getNewBlock(item){
	// refreshDelay = setTimeout(autoRefresh, 1000);
	// autoRefresh();
}

function autoRefresh(){
	
	$.getJSON('refresh', function(data){
		$('.response').html(fillTemplate(data));
		$('.programme-block-container').fadeIn('slow');
		
	})
}

function fillTemplate(data){
	clearTimeout(refreshDelay);
	clearInterval(refreshPage);
	var source   = $("#programme-block-template").html();
	var template = Handlebars.compile(source);
	refreshPage = setInterval(isRefreshRequired, 2000);
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



function gdoUpdateProgression(){
	$('.programme-block-container').each(function() {
		var start = $(this).data('start');
		var end = $(this).data('end');
		var p = gdoGetProgression(start, end);
		$(this).find('.progress-bar').css('width', p+'%');			
	});

	$('.programme-block-container').each(function(){
		var start = $(this).data('start');
		var now = moment();		
		if(moment(start).isBefore(now)) $(this).find('.time-color').css('color', 'red');		
	});
}