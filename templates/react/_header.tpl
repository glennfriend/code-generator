<div class="bar1">
    [main]
    <a href="?t=my_page">page</a>,
    <a href="?t=my_list">list</a>,
    <a href="?t=my_list_table">list_table</a>,
    <a href="?t=my_form">form</a>,
    <a href="?t=my_create_form">create_form</a>,
    <a href="?t=my_update_form">update_form</a>,
    [service]
    <a href="?t=my_service">service</a>,
    [----]
    <a href="?t=core_interfaces">core interfaces</a>,
    <a href="?t=basic_form">basic from</a>,
    <a href="?t=modal_show_content_by_api">modal_show_content_by_api</a>,
    <a href="?t=modal_show_content_use_table">modal_show_content_use_table</a>,
    [component]
    <a href="?t=component_select">select</a>,
</div>

<div class="bar2">
    {{if isset($smarty.get.t)}}
        [<a href='create.php?t={{$smarty.get.t}}'>create</a>]
    {{/if}}
    {{$cf.path}}{{$cf.filename}}
</p>
