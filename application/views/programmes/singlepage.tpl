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

	<div class="container" id="app">

		<div class="subnav menu clearfix">
			{include file="programmes/main-menu.tpl"}
		</div>
		<div class="row">
			<div class="response">
				<program-card v-for="(item, index) in datas" :prog='item' :key="index"></program-card>
			</div>
		</div>
		{include file="programmes/channelselection.tpl"}
	</div>
	

{literal}
<template id="prog-card">
	<div class="col-xs-12 col-sm-4 col-md-3 programme-block-container">
		<div class="programme-block clearfix">
			<img v-bind:src="prog.imgurl" onerror="this.src='img/error_img.png'"/>
			<div class="program-details">
				<p class="program-channel"><strong>{{prog.name}}</strong> - <span class="time-color">{{prog.start|hour}}</span> - <span>{{prog.end|hour}}</span></p>
				<p class="program-title">{{prog.title}}<em v-if='prog.subtitle'> - {{prog.subtitle}}</em></p>
				<div class="progression">
					<div class="progress">
						<div class="progress-bar" v-bind:style="progressionStyle"></div>
					</div>
					<p class="program-length"><em>{{prog.length}}mn</em></p>
				</div>	        
			</div>
		</div>
	</div>
</template>
{/literal}


<template id="channel-list">
	<form>
		<div class="modal-body">
			{nocache}
				{foreach $channels as $item}
					<div class="checkbox">
						<label for="channel{$item->channelId}">
						<input
							class="channel"
							type="checkbox"							
							id="channel{$item->channelId}"
							v-model="checkedNames"
							v-on:click="addChannel"
							value="{$item->channelId}"> {$item->name}
						</label>
					</div>						
				{/foreach}
			{/nocache}			
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
			<button type="button" class="btn btn-primary" @click="getChannels" data-dismiss="modal">Appliquer</button>
		</div>
	</form>
</template>




{/block}

{block "scripts"}
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/locale/fr.js"></script>
{* <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.10/handlebars.min.js"></script> *}
<script src="{base_url('js/js.cookie.js')}"></script>
{* <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.4.1/vue.min.js"></script> *}
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.4.1/vue.js"></script>
<script src="{base_url('js/main-menu.js')}"></script>
{* <script src="{base_url('js/gdo.js')}"></script> *}
{/block}