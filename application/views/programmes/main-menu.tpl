{literal}	
		<div>
			<button class="btn btn-default"
					@click="refresh('A', 'refresh')"
					:class="{activated: isActive('A')}">
					En cours
			</button>

			<button class="btn btn-default"
					@click="refresh('B', 'getEveningPrograms/?creneau=1')"
					:class="{activated: isActive('B')}">
					Soirée 1
			</button>

			<button class="btn btn-default"
					@click="refresh('C', 'getEveningPrograms/?creneau=2')"
					:class="{activated: isActive('C')}">
					Soirée 2
			</button>
		</div>
{/literal}