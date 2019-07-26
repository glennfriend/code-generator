<?php

$obj = new NamePrototype(getProjectName());
$mod = new NamePrototype(getDaoName());
$today = date("Y_m_d");

return [

    'value_object' => [
        'path'          => "app/Entities/",
        'filename'      => "{$obj->upperCamel()}.php",
        'clear_comment' => false,
    ],
    'eloquent' => [
        'path'          => "app/Entities/Eloquent/",
        'filename'      => "{$obj->upperCamel()}Eloquent.php",
        'clear_comment' => false,
    ],
    'model' => [
        'path'          => "app/Entities/",
        'filename'      => "{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ],
    'model_extend' => [
        'path'          => "app/Entities/",
        'filename'      => "{$mod->upperCamel()}.php",
        'clear_comment' => false,
    ],
    'search_table' => [
        'path'          => "app/Entities/SearchTable/",
        'filename'      => "{$mod->upperCamel()}.php",
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
        'path'          => "tests/app/Unit/Entities/",
        'filename'      => "{$obj->upperCamel()}Test.php",
        'clear_comment' => false,
    ],
    'test_api' => [
        'path'          => "tests/app/Feature/Api/",
        'filename'      => "{$obj->upperCamel()}ApiTest.php",
        'clear_comment' => false,
    ],
    'database_factory' => [
        'path'          => "app/database/factories/",
        'filename'      => "{$obj->upperCamel()}Facotry.php",
        'clear_comment' => false,
    ],
  
    // for debug
    'debug_only' => [
        'path'          => "app/",
        'filename'      => "Debug.php",
        'clear_comment' => false,
    ],
    
];

//