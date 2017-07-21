{extends file="master.tpl"}

{block "view"}
	<div id="app">
	<nav class="navbar navbar-default">
		<div class="container">
			<div class="navbar-header">			
				{literal}<span class="navbar-brand">Programmes TV du {{currentDate}}</span>{/literal}
			</div>
			<p class="navbar-text navbar-right channel-selection" data-toggle="modal" data-target="#channelSelection">Liste des chaînes</p>
		</div>
	</nav>

	<div class="container">
		<div class="subnav menu clearfix">
			{include file="programmes/main-menu.tpl"}
		</div>
		<div class="row">
			<div class="response">
				<program-card v-for="(item, index) in datas" :prog='item' :key="index"></program-card>
			</div>
		</div>

		<div class="modal fade bs-example-modal-sm" id="channelSelection">
		  <div class="modal-dialog modal-sm" >
		    <div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Mes chaînes préférées</h4>
				</div>
			    {literal}<chanl-list @channel-list-updated="updateChannels"></chanl-list>{/literal}
		    </div>
		  </div>
		</div>		
	</div>
	</div>

{include file="programmes/vuetemplate-programblock.tpl"}
{include file="programmes/vuetemplate-channelselection.tpl"}
{/block}

{block "scripts"}
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/locale/fr.js"></script>
<script src="{base_url('js/js.cookie.js')}"></script>
{* <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.4.1/vue.min.js"></script> *}
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.4.1/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue-resource/1.3.4/vue-resource.min.js"></script>
<script src="{base_url('js/main-menu.js')}"></script>
{* <script src="{base_url('js/gdo.js')}"></script> *}
{/block}