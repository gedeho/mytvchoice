<div class="modal fade bs-example-modal-lg" id="channelSelection">
  <div class="modal-dialog modal-sm" >
    <div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title">Mes chaînes préférées</h4>
		</div>
		<form>
			<div class="modal-body">
				{nocache}
				{foreach $channels as $item}
					<div class="checkbox">
						<label>
							<input class="channel" type="checkbox" name="channel{$item->channelId}" value="{$item->channelId}"> {$item->name}
						</label>
					</div>						
				{/foreach}
				{/nocache}			
			</div>
			<div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
		        <button type="button" class="btn btn-primary save-channels" data-dismiss="modal">Enregistrer</button>
		  	</div>
	  	</form>      
    </div>
  </div>
</div>