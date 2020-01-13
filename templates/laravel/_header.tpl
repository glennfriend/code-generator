<div class="bar1">
    <a href="?t=value_object">Value Object</a>,
    <a href="?t=eloquent">Eloquent</a>,
    <a href="?t=json_resource">Json Resource</a>,
    <a href="?t=model">Model</a>,
    <a href="?t=model_extend">Model Extend</a>,
    <a href="?t=search_table">Search Table</a>,
    <a href="?t=migration">Migration</a>,
    <a href="?t=migration_view">Migration view</a>,
    <a href="?t=locale">Locale</a>,
    <a href="?t=home_controller">HomeController</a>,
    <a href="?t=home_api_controller">HomeApi</a>,
    <a href="?t=job">job</a>,
    <a href="?t=business_service">Service</a>,
    <a href="?t=business_helper">Helper</a>
    <br>
    [view]
        <a href="?t=view_index">index</a>,
        <a href="?t=view_create">create</a>,
        <a href="?t=js_object">js object</a>
    [test]
        <a href="?t=test_value_object">Value Object</a>
        <a href="?t=test_api">Api</a>
        <a href="?t=test_controller">controller</a>
        <a href="?t=test_job">job</a>
        <a href="?t=test_service">service</a>
        <a href="?t=test_data">data</a>
        <a href="?t=database_factory">database/factories</a>
    [other]
        <a href="?t=debug_only">D</a>
    [Kos]
        <a href="?t=kos_home_controller_api">ControllerApi</a>,
        <a href="?t=kos_repository">Repository</a>
        <a href="?t=kos_service">Service</a>
        <a href="?t=kos_provider">Provider</a>
</div>

<div class="bar2">
    {if isset($smarty.get.t)}
        [<a href='create.php?t={$smarty.get.t}'>create</a>]
    {/if}
    {$cf.path}{$cf.filename}
</p>
