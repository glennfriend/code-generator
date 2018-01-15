<div class="bar1">
    <a href="?t=value_object">ValueObject</a>,
    <a href="?t=eloquent">Eloquent</a>,
    <a href="?t=model">Model</a>,
    <a href="?t=model_extend">Model Extend</a>,
    <a href="?t=search_table">Search Table</a>,
    <a href="?t=migration">Migration</a>,
    <a href="?t=locale">Locale</a>,
    <a href="?t=home_controller">HomeController</a>,
    <a href="?t=home_ajax_controller">HomeAjaxController</a>,
    <a href="?t=business_service">Service</a>,
    <a href="?t=business_helper">Helper</a>
    view {
        <a href="?t=index_view">Index</a>,
        <a href="?t=new_view">New</a>,
        <a href="?t=js_object">js object</a>
    }
    test {
        <a href="?t=test_db_object">DbObject</a>
    }
</div>

<div class="bar2">
    {if isset($smarty.get.t)}
        [<a href='create.php?t={$smarty.get.t}'>create</a>]
    {/if}
    {$cf.path}{$cf.filename}
</p>
