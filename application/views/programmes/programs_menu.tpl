{nocache}
<nav class="navbar navbar-default">
	<div class="container">

		<div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Programmes TV</a>
    </div>

	<div class="collapse navbar-collapse" id="bs-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li {if $pageId==0}class="active"{/if}>{anchor('programmestv/getCurrent', 'Live')}</li>
			<li {if $pageId==1}class="active"{/if}>{anchor('programmestv/getPrograms/1', 'Tonight 1')}</li>
			<li {if $pageId==2}class="active"{/if}>{anchor('programmestv/getPrograms/2', 'Tonight 2')}</li>
			{* <li><a href="#">Custom</a></li> *}
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li >{anchor('programmestv/updateFeed', 'Update Database')}</li>
		</ul>
	</div>

	</div>
</nav>
{/nocache}