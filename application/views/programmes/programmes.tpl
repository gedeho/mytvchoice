{extends file="master.tpl"}

{block "view"}
  {include file="programmes/programs_menu.tpl"}
  <div class="container">
    <div class="row">
    {block "subnav"}{/block}

    {nocache}
      <div class="response col-xs-12">
        {foreach $programs as $item}
          {include file="programmes/programblock.tpl"}
        {/foreach}
      </div>
    {/nocache}

    </div>
  </div>

  {block "programme-block-template"}{/block}
{/block}

{block "scripts"}
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/locale/fr.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.10/handlebars.min.js"></script>
<script src="{base_url('js/gdo.js')}"></script>
{/block}