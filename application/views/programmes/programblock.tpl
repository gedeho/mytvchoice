{assign var="start" value=$item->start|date_format:"%H:%M"}
{assign var="end" value=$item->end|date_format:"%H:%M"}
<div class="col-xs-6">
  <div class="programme-block clearfix">
		<img class="pull-left" src="{$item->imgurl}" onerror="this.src='{base_url('img/error_img.png')}'"/>
		<div>				
			<p><strong>{$item->name}</strong> - <span class="time-color" data-start="{$item->start}">{$start}</span> - <span>{$end}</span></p>
			<p>{$item->title} {if $item->subtitle}- {$item->subtitle}{/if}</p>
      <div class="progress">
        <div class="progress-bar" style="width: 0%;" data-start='{$item->start}' data-end='{$item->end}'></div>
      </div>
			<p><em>{$item->length}mn</em></p>
		</div>
  </div>
</div>