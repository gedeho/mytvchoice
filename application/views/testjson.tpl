{include file="commons/programs_menu.tpl"}
<div class="container">
	<div class="row">
		<div class="col-xs-12">
			<input class="btn btn-default get-datas" type="button" value="Refresh">
		</div>
		{* <div class="testfade" style="display:none; witdh:200px; height:200px; background:red;"></div> *}
		<div class="response col-xs-12">
		</div>
	</div>
</div>

{literal}
	<script id="programme-block-template" type="text/x-handlebars-template">
	{{#each this}}

	<div class="col-xs-6 testfade">
		<div class="programme-block  clearfix">
			<img class="pull-left" src="{{imgurl}}" onerror="this.src='../img/error_img.png'"/>
			<div>				
				<p><strong>{{name}}</strong> - <span class="time-color" data-start="{{start}}">{{fstart start}}</span> - <span>{{fend end}}</span></p>
				<p>{{title}} - {{subtitle}}</p>
				<div class="progress">
					<div class="progress-bar" style="width: 0%;" data-start='{{start}}' data-end='{{end}}'></div>
				</div>
				<p><em>{{length}}mn</em></p>
			</div>
		</div>
	</div>

	{{/each}}
	</script>
{/literal}