<div class="bar1">
    <a href="?t=value_object">Value Object</a>,
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
    <br>
    [view]
        <a href="?t=view_index">index</a>,
        <a href="?t=view_create">create</a>,
        <a href="?t=js_object">js object</a>
    [test]
        <a href="?t=test_value_object">Value Object</a>
</div>

<div class="bar2">
    {if isset($smarty.get.t)}
        [<a href='create.php?t={$smarty.get.t}'>create</a>]
    {/if}
    {$cf.path}{$cf.filename}
</p>
