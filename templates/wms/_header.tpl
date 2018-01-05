<div class="bar1">
    <a href="?t=dbobject">dbObject</a>,
    <a href="?t=model">model</a>,
    <a href="?t=modelExtend">modelExtend</a>,
    <a href="?t=locale">Locale</a>,
    <a href="?t=homeController">homeController</a>,
    <a href="?t=searchTable">SearchTable</a>,
    view {
        <a href="?t=index_view">index</a>,
        <a href="?t=new_view">vew</a>,
        <a href="?t=jsObject">js object</a>
    }
</div>

<div class="bar2">
    {if isset($smarty.get.t)}
        [<a href='create.php?t={$smarty.get.t}'>create</a>]
    {/if}
    {$cf.path}{$cf.filename}
</p>
