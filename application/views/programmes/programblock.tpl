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