<?php

$obj = new NamePrototype(getProjectName());
$mod = new NamePrototype(getDaoName());
$today = date("Y_m_d");

return [

    'value_object' => [
        'path'          => "app/Db/",
        'filename'      => "{$obj->upperCamel()}.php",
        'clear_comment' => false,
    ],
    'eloquent' => [
        'path'          => "app/Db/Eloquent/",
        'filename'      => "{$obj->upperCamel()}Emodel.php",
        'clear_comment' => false,
    ],
    'model' => [
        'path'          => "app/Db/",
        'filename'      => "{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ],
    'model_extend' => [
        'path'          => "app/Db/",
        'filename'      => "{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ],
    'search_table' => [
        'path'          => "app/Db/SearchTable/",
        'filename'      => "Search{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ],
    'migration' => [
        'path'          => "database/migrations/",
        'filename'      => $today ."_000001_{$mod->lower('_')}_table.php",
        'clear_comment' => false,
    ],

    //
    'locale' => [
        'path'          => "resource/locale/",
        'filename'      => "zh_tw.php",
        'clear_comment' => false,
    ],

    // controller
    'home_controller' => [
        'path'          => "app/Http/Controllers/{$obj->upperCamel()}/",
        'filename'      => "HomeController.php",
        'clear_comment' => false,
    ],
    'home_ajax_controller' => [
        'path'          => "app/Http/Controllers/{$obj->upperCamel()}/",
        'filename'      => "HomeAjaxController.php",
        'clear_comment' => false,
    ],

    // business layer
    'business_service' => [
        'path'          => "app/Service/{$obj->upperCamel()}/",
        'filename'      => "{$obj->upperCamel()}Service.php",
        'clear_comment' => false,
    ],
    'business_helper' => [
        'path'          => "app/Service/{$obj->upperCamel()}/",
        'filename'      => "{$obj->upperCamel()}Helper.php",
        'clear_comment' => false,
    ],

    // js
    'js' => [
        'path'          => "home/admin/dist/{$obj}/",
        'filename'      => "main.js",
        'clear_comment' => false,
    ],
    'js_object' => [
        'path'          => "home/admin/dist/{$obj}/",
        'filename'      => "{$obj}.js",
        'clear_comment' => false,
    ],

    // view
    'view_index' => [
        'path'          => "resourdce/views/{$obj}/views/",
        'filename'      => "home.index.phtml",
        'clear_comment' => false,
    ],
    'view_create' => [
        'path'          => "resourdce/views/{$obj}/views/",
        'filename'      => "home.create.phtml",
        'clear_comment' => false,
    ],
    'view_edit' => [
        'path'          => "resourdce/views/{$obj}/views/",
        'filename'      => "home.edit.phtml",
        'clear_comment' => false,
    ],

    // test
    'test_value_object' => [
        'path'          => "tests/app/Db/",
        'filename'      => "{$obj->upperCamel()}Test.php",
        'clear_comment' => false,
    ],

];

//