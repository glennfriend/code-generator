<div class="bar1">
    <a href="?t=basic_form">basic from</a>,
    <a href="?t=modal_show_content_by_api">modal_show_content_by_api</a>,
    [component]
    <a href="?t=component_select">select</a>,
</div>

<div class="bar2">
    {{if isset($smarty.get.t)}}
        [<a href='create.php?t={{$smarty.get.t}}'>create</a>]
    {{/if}}
    {{$cf.path}}{{$cf.filename}}
</p>
