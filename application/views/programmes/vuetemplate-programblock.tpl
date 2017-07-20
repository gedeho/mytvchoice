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