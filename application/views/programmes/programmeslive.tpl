{extends file="programmes/programmes.tpl"} 
{block "subnav"}
	<div class="col-xs-12 subnav">

	<div class="row subnav">
		<input class="btn btn-default get-datas" type="button" value="Refresh">
	</div>		

	<div class="row subnav">
		<form class="form-inline">
			<div class="form-group">
				<label for="finishIn">Fin dans moins de </label>
				<input type="number" class="form-control" id="finishIn" placeholder="30" value="30" step="10">
				<label >mn </label>   
			</div>
			<div class=" form-group">
				<input class="btn btn-default get-soonFinished" type="button" value="Get sample">
			</div>
		</form>
	</div>

	<div class="row subnav">
		<form class="form-inline">
			<div class="form-group">
				<label for="startIn">Début dans moins de </label>
				<input type="number" class="form-control" id="startIn" placeholder="30" value="30" step="10">
				<label >mn </label>   
			</div>
				<div class=" form-group">
				<input class="btn btn-default get-soonStarted" type="button" value="Get sample">
			</div>
		</form>
	</div>
	
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