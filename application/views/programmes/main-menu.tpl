{literal}
<div class="container">
	<row>
		<div id="app">
		  <span v-if="seen">{{ message }}</span>
		  <button class="btn btn-default" v-bind:disabled="isButtonDisabled">Button</button>
		</div>
	</div>
</div>
{/literal}