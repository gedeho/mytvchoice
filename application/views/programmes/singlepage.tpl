{extends file="master.tpl"}

{block "view"}
	<nav class="navbar navbar-default">
		<div class="container">
			<div class="navbar-header">			
				<span class="navbar-brand">Programmes TV du <span class="date-title"></span></span>
			</div>
			<p class="navbar-text navbar-right channel-selection" data-toggle="modal" data-target="#channelSelection">Liste des chaînes</p>
		</div>
	</nav>

	<div class="container">

		<div class="subnav clearfix">
			<div class="col-xs-12 option-toggle control-buttons " data-toggle="buttons">		
				{* <a class="btn btn-default" data-toggle="collapse" href="#collapse" >Options</a>	 *}
				<label class="btn btn-default now active">
					<input type="radio" name="options" id="option1" autocomplete="off" checked> En cours
				</label>
				<label class="btn btn-default prog1">
					<input type="radio" name="options" id="option2" autocomplete="off"> Soirée 1
				</label>
				<label class="btn btn-default prog2">
					<input type="radio" name="options" id="option3" autocomplete="off"> Soirée 2
				</label>
			</div>
			<div class="collapse col-xs-12" id="collapse">
				<form>
					<div class="form-group">
						<span>Fin dans moins de :</span>
						<input type="number" class="form-control" id="finishIn" placeholder="30" value="30" step="10">
						<span>mn</span>
						<input class="btn btn-default pull-right get-soonFinished" type="button" value="Go !">
					</div>

					<div class="form-group">
						<span >Début dans moins de :</span>
						<input type="number" class="form-control" id="startIn" placeholder="30" value="30" step="10">
						<span>mn</span>
						<input class="btn btn-default pull-right get-soonStarted" type="button" value="Go !">   
					</div>
				</form>	
			</div>
		</div>
		<div class="row">
			<div class="response"></div>
		</div>
	</div>
	{include file="programmes/channelselection.tpl"}
	{literal}
		<script id="programme-block-template" type="text/x-handlebars-template">
			{{#each this}}
				<div class="col-xs-12 col-sm-4 col-md-3 programme-block-container" data-name="{{title}}" data-start='{{start}}' data-end="{{end}}">
					<div class="programme-block  clearfix">
					  <img src="{{imgurl}}" onerror="this.src='img/error_img.png'"/>
					  <div class="program-details">
					  	<p class="program-channel"><strong>{{name}}</strong> - <span class="time-color">{{fstart start}}</span> - <span>{{fend end}}</span></p>
					        <p class="program-title">{{title}}{{#if subtitle}}<em> - {{subtitle}}{{/if}}</em></p>
					        <div class="progression">
						        <div class="progress">
						          <div class="progress-bar" style="width: 0%;"></div>
						        </div>
						        <p class="program-length"><em>{{length}}mn</em></p>
					        </div>	        
					  </div>
					</div>
				</div>
			{{/each}}
		</script>
	{/literal}
{/block}

{block "scripts"}
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/locale/fr.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.10/handlebars.min.js"></script>
<script src="{base_url('js/js.cookie.js')}"></script>
<script src="{base_url('js/gdo.js')}"></script>
{/block}