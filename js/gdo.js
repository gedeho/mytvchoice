'use strict'

var refreshPage;
var source;
var template;
var programGrid;
var terminatedPrograms = new Array();
var channelSelection = new Array();

$(document).ready(function(){

	// Get the program-grid area :
	programGrid = $('.response');

	// Get & compile the Program-block Template :
	source = $("#programme-block-template").html();
	if(source){template = Handlebars.compile(source);}

	// Update Progress-Bars & Start-Time color every 1500ms :
	gdoUpdateProgression();
	var refreshProgress = setInterval(gdoUpdateProgression, 1500);

	// Look for Terminated-Programs every 15 seconds :
	refreshPage = setInterval(FindTerminatedPrograms, 15000);

	// Intialize the user-interface :
	gdoInitUserInterface();	

	// Check channels in "Channel Selection" popin according to cookie value :
	initChannelSelection();
});

function gdoInitUserInterface(){
	$('.get-datas').on('click', function(){gdoRefresh();});
	$('.save-channels').on('click', function(){saveSelectedChannels();});
	$('.get-soonFinished').on('click', function(){getPrograms('#finishIn', 'getSoonFinished');});
	$('.get-soonStarted').on('click', function(){getPrograms('#startIn', 'getSoonStarted');});
}

function initChannelSelection(){
	if(Cookies.getJSON('channelselection') != null){
		Cookies.getJSON('channelselection').forEach(function(element){
			$("input[value="+element+"]").attr('checked', true);
		});
	}
}

function gdoRefresh(){
	var selectedChannels = getChannelSelection();
	$.getJSON('refresh',{channels:selectedChannels}).done(function(data){
		programGrid.html(template(data));
	});	
}

function getChannelSelection(){
	if(Cookies.getJSON('channelselection') != null){
		return Cookies.getJSON('channelselection');
	}
	else{
		if(channelSelection.length <= 0){
		$("input:checked").each(function(){
			channelSelection.push($(this).val());
		});
	}
	return channelSelection;
	}	
}

function saveSelectedChannels(){
	channelSelection.length = 0;
	$("input:checked").each(function(){
		channelSelection.push($(this).val());
	});
	Cookies.set('channelselection', channelSelection, {expires:7});
	gdoRefresh();
}

function getPrograms(field, action){
	var requestedValue = $(field).val();
	$.getJSON(action,{a:requestedValue}).done(function(data){
		programGrid.html(template(data));
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

