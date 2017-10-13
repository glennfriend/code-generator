<?php

$tableName = new NamePrototype(getTable());
$today = date("Ymd");

return [

    'model' => array(
        'path'          => "tmp/",
        'filename'      => "{$tableName->upperCamel()}.php",
        'clear_comment' => false,
    ),
    'search' => array(
        'path'          => "protected/SearchTable/",
        'filename'      => "{$tableName->upperCamel()}.php",
        'clear_comment' => false,
    ),
    'shell' => array(
        'path'          => "protected/shell/",
        'filename'      => "rebuild-all-{$tableName->lower('-')}.php",
        'clear_comment' => false,
    ),
    'migration' => array(
        'path'          => "protected/migrations/",
        'filename'      => "Version{$today}_{$tableName->upperCamel('_')}.php",
        'clear_comment' => false,
    ),

];

