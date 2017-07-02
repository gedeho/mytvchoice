{extends file="programmes/programmes.tpl"} 
{block "subnav"}
	<div class="col-xs-12 subnav">
		<input class="btn btn-default get-datas" type="button" value="Refresh">
	</div>
{/block}

{block "programme-block-template"}
	{literal}
	  <script id="programme-block-template" type="text/x-handlebars-template">
	  {{#each this}}
	  <div class="col-xs-6 programme-block-container" data-name="{{title}}" data-start='{{start}}' data-end="{{end}}">
	    <div class="programme-block  clearfix">
	      <img class="pull-left" src="{{imgurl}}" onerror="this.src='../img/error_img.png'"/>
	      <div>       
	        <p><strong>{{name}}</strong> - <span class="time-color">{{fstart start}}</span> - <span>{{fend end}}</span></p>
	        <p>{{title}} - {{subtitle}}</p>
	        <div class="progress">
	          <div class="progress-bar" style="width: 0%;"></div>
	        </div>
	        <p><em>{{length}}mn</em></p>
	      </div>
	    </div>
	  </div>
	  {{/each}}
	  </script>
	{/literal}
{/block}