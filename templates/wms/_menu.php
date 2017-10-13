<?php

$obj = new NamePrototype(getProjectName());
$mod = new NamePrototype(getDaoName());

return [

    'dbobject' => array(
        'path'          => "protected/models/",
        'filename'      => "{$obj->upperCamel()}.php",
        'clear_comment' => false,
    ),
    'model' => array(
        'path'          => "protected/models/",
        'filename'      => "{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ),

    //
    'locale' => array(
        'path'          => "protected/messages/zh_tw/",
        'filename'      => "lang.php",
        'clear_comment' => false,
    ),

    // controller
    'homeController' => array(
        'path'          => "protected/modules/{$obj->lower()}/controllers/",
        'filename'      => "HomeController.php",
        'clear_comment' => false,
    ),

    // js
    'js' => array(
        'path'          => "admin/modules/{$obj}/",
        'filename'      => "main.js",
        'clear_comment' => false,
    ),
    'jsObject' => array(
        'path'          => "admin/modules/{$obj}/",
        'filename'      => "{$obj}.js",
        'clear_comment' => false,
    ),

    // view
    'index_view' => array(
        'path'          => "protected/modules/{$obj->lower()}/views/home/",
        'filename'      => "index.php",
        'clear_comment' => false,
    ),
    'new_view' => array(
        'path'          => "protected/modules/{$obj->lower()}/views/home/",
        'filename'      => "new.php",
        'clear_comment' => false,
    ),
    'edit_view' => array(
        'path'          => "protected/modules/{$obj->lower()}/views/home/",
        'filename'      => "edit.php",
        'clear_comment' => false,
    ),

];
