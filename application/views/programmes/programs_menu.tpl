{nocache}
<nav class="navbar navbar-default">
	<div class="container">
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
</nav>
{/nocache}