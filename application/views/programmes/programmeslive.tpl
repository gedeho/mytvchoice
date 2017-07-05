{extends file="programmes/programmes.tpl"} 
{block "subnav"}
<div class="subnav clearfix">
	<div class="col-xs-12 option-toggle">		
		<a class="btn btn-default" data-toggle="collapse" href="#collapse" >Options</a>
		<input class="btn btn-primary pull-right get-datas" type="button" value="Actualiser">
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
{/block}

{block "programme-block-template"}
	{literal}
	  <script id="programme-block-template" type="text/x-handlebars-template">
	  {{#each this}}
	  <div class="col-xs-12 col-sm-4 col-md-3 programme-block-container" data-name="{{title}}" data-start='{{start}}' data-end="{{end}}">
	    <div class="programme-block  clearfix">
	      <img src="{{imgurl}}" onerror="this.src='../img/error_img.png'"/>
	      <div class="program-details">
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
	  </div>
	  {{/each}}
	  </script>
	{/literal}
{/block}