{assign var="start" value=$item->start|date_format:"%H:%M"}
{assign var="end" value=$item->end|date_format:"%H:%M"}
<div class="col-xs-12 col-sm-4 col-md-3  programme-block-container" data-name="{$item->title}" data-start='{$item->start}' data-end="{$item->end}">
  <div class="programme-block clearfix">
		<img src="{$item->imgurl}" onerror="this.src='{base_url('img/error_img.png')}'"/>
		<div class="program-details">
			<p class="program-channel"><strong>{$item->name}</strong> - <span class="time-color">{$start}</span> - <span>{$end}</span></p>
			<p class="program-title">{$item->title} {if $item->subtitle}<em>- {$item->subtitle}</em>{/if}</p>
			<div class="progression">
				<div class="progress">
					<div class="progress-bar" style="width: 0%;"></div>
				</div>
				<p class="program-length"><em>{$item->length}mn</em></p>
			</div>				
		</div>
  </div>
</div>