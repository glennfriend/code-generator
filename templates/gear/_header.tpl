
<div style='font-size:13px; margin:0px; padding:0px;'>
  <a href="?t=dbobject">DbObject</a>
, <a href="?t=model">Model</a>
, <a href="?t=locale">Locale</a>
, <a href="?t=homeController">HomeController</a>
, view {
  <a href="?t=index_view">Index</a>
, <a href="?t=new_view">New</a>
, <a href="?t=jsObject">js object</a>
  }
</div>

<p style='Font-family:dina,細明體;font-size:13px; margin:5px; padding:0px;'>
    [path-filename] = {$cf.path}{$cf.filename}
    {if isset($smarty.get.t)}
        <br />[<a href='create.php?t={$smarty.get.t}'>status</a>]
    {/if}
</p>
