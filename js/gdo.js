'use strict'

var refreshPage;
var source;
var template;
var terminatedPrograms = new Array();

$(document).ready(function(){

	// Get & compile the Program-block Template :
	source = $("#programme-block-template").html();
	if(source){template = Handlebars.compile(source);}

	// Start Progress-bar & Start-time update process :
	gdoUpdateProgression();
	var refreshProgress = setInterval(gdoUpdateProgression, 1500);

	// Start the Terminated-Programs removing process :
	refreshPage = setInterval(FindTerminatedPrograms, 2000);

	// Intialize the user-interface :
	gdoInitUserInterface();	
});

function gdoInitUserInterface(){
	$('.get-datas').on('click', function(){gdoRefresh();});
	$('.get-soonFinished').on('click', function(){getPrograms('#finishIn', 'getSoonFinished');});
	$('.get-soonStarted').on('click', function(){getPrograms('#startIn', 'getSoonStarted');});
}

function gdoRefresh(){
	$.getJSON('refresh', function(data){
		$('.response').html(fillTemplate(data));		
	});
}

function getPrograms(field, action){
	var requestedValue = $(field).val();
	$.getJSON(action,{a:requestedValue}).done(function(data){
		$('.response').html(fillTemplate(data));
	});
}

// '2017-07-02 17:15:00'
function FindTerminatedPrograms(){
	$('.programme-block-container').each(function(){
		var item = $(this);		
		var end = item.data('end');
		var now = moment();
		if(moment(now).isAfter(end)){
			console.log('Programme '+item.data('name')+' terminé ('+end+')');
			terminatedPrograms.push(item);
		} 
	});
	removeTerminatedPrograms();
}

function fillTemplate(data){
	// Reset the Terminated-Programs removing process :
	clearInterval(refreshPage);
	refreshPage = setInterval(FindTerminatedPrograms, 2000);
	return template(data);
}

function removeTerminatedPrograms(){
	terminatedPrograms.forEach(function(item){
		item.fadeOut('slow', function(){
			item.remove();
		});
	});
	terminatedPrograms.length = 0;
}

Handlebars.registerHelper('fstart', function(){
	return moment(this.start).format('HH:mm');
});
Handlebars.registerHelper('fend', function(){
	return moment(this.end).format('HH:mm');
});


function gdoUpdateProgression(){
	updateProgressBar();
	updateStartColor();	
}

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

function updateProgressBar(){
	$('.programme-block-container').each(function() {
		var start = $(this).data('start');
		var end = $(this).data('end');
		var p = gdoGetProgression(start, end);
		$(this).find('.progress-bar').css('width', p+'%');			
	});
}

function updateStartColor(){
	$('.programme-block-container').each(function(){
		var start = $(this).data('start');
		var now = moment();		
		if(moment(start).isBefore(now)) $(this).find('.time-color').css('color', 'red');		
	});
}