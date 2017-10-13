<?php

$st = get('st');
$searchTable = new NamePrototype($st);

return [

    'search' => array(
        'path'          => "protected/models/search/table/",
        'filename'      => "{$searchTable->upperCamel()}.php",
        'clear_comment' => false,
    ),
    'shell' => array(
        'path'          => "protected/shell/",
        'filename'      => "rebuild-all-{$searchTable->lower('-')}.php",
        'clear_comment' => false,
    ),

];

