<?php

$obj = new NamePrototype(SessionManager::projectKey());
$mod = new NamePrototype(SessionManager::daoName());
$today = date("Ymd");

return [

    'dbobject' => array(
        'path'          => "app/Model/",
        'filename'      => "{$obj->upperCamel()}.php",
        'clear_comment' => false,
    ),
    'model' => array(
        'path'          => "app/Model/",
        'filename'      => "{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ),
    'modelExtend' => array(
        'path'          => "app/Model/",
        'filename'      => "{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ),
    'migration' => array(
        'path'          => "resource/migrations/",
        'filename'      => "Version". $today ."_{$mod->upperCamel('_')}.php",
        'clear_comment' => false,
    ),

    //
    'locale' => array(
        'path'          => "resource/locale/",
        'filename'      => "zh_tw.php",
        'clear_comment' => false,
    ),

    // controller
    'homeController' => array(
        'path'          => "App/Controllers/{$obj->upperCamel()}/",
        'filename'      => "HomeController.php",
        'clear_comment' => false,
    ),
    'homeAjaxController' => array(
        'path'          => "App/Controllers/{$obj->upperCamel()}/",
        'filename'      => "HomeAjaxController.php",
        'clear_comment' => false,
    ),

    // business layer
    'businessService' => array(
        'path'          => "App/Business/{$obj->upperCamel()}/",
        'filename'      => "{$obj->upperCamel()}Service.php",
        'clear_comment' => false,
    ),
    'businessHelper' => array(
        'path'          => "App/Business/{$obj->upperCamel()}/",
        'filename'      => "{$obj->upperCamel()}Helper.php",
        'clear_comment' => false,
    ),

    // js
    'js' => array(
        'path'          => "home/admin/dist/{$obj}/",
        'filename'      => "main.js",
        'clear_comment' => false,
    ),
    'jsObject' => array(
        'path'          => "home/admin/dist/{$obj}/",
        'filename'      => "{$obj}.js",
        'clear_comment' => false,
    ),

    // view
    'index_view' => array(
        'path'          => "resourdce/views/{$obj}/views/",
        'filename'      => "home.index.phtml",
        'clear_comment' => false,
    ),
    'new_view' => array(
        'path'          => "resourdce/views/{$obj}/views/",
        'filename'      => "home.new.phtml",
        'clear_comment' => false,
    ),
    'edit_view' => array(
        'path'          => "resourdce/views/{$obj}/views/",
        'filename'      => "home.edit.phtml",
        'clear_comment' => false,
    ),

    // test
    'testDbobject' => array(
        'path'          => "test/model/",
        'filename'      => "{$obj->upperCamel()}Test.php",
        'clear_comment' => false,
    ),

];

//