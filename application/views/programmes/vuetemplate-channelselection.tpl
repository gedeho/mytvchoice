<template id="channel-list">
	<form>
		<div class="modal-body">
			{nocache}
				{foreach $channels as $item}
					<div class="checkbox">
						<label for="channel{$item->channelId}">
						<input
							class="channel"
							type="checkbox"							
							id="channel{$item->channelId}"
							v-model="checkedNames"
							v-on:click="addChannel"
							value="{$item->channelId}"> {$item->name}
						</label>
					</div>						
				{/foreach}
			{/nocache}			
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
			<button type="button" class="btn btn-primary" @click="getChannels" data-dismiss="modal">Appliquer</button>
		</div>
	</form>
</template>




