<div class="bar1">
    <a href="?t=dbobject">DbObject</a>,
    <a href="?t=model">Model</a>,
    <a href="?t=locale">Locale</a>,
    <a href="?t=homeController">HomeController</a>,
    view {
        <a href="?t=index_view">Index</a>,
        <a href="?t=new_view">New</a>,
        <a href="?t=jsObject">js object</a>
    }
</div>

<div class="bar2">
    {if isset($smarty.get.t)}
        [<a href='create.php?t={$smarty.get.t}'>create</a>]
    {/if}
    {$cf.path}{$cf.filename}
</p>
