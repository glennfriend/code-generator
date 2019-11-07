<?php

$obj = new NamePrototype(SessionManager::projectName());
$mod = new NamePrototype(SessionManager::daoName());
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
    'json_resource' => [
        'path'          => "app/Http/Resources/",
        'filename'      => "{$obj->upperCamel()}.php",
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
        'path'          => "app/database/migrations/",
        'filename'      => $today ."_000001_create_{$mod->lower('_')}_table.php",
        'clear_comment' => false,
    ],
    'migration_view' => [
        'path'          => "app/database/migrations/",
        'filename'      => $today ."_000001_create_{$mod->lower('_')}_view.php",
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
        'filename'      => "{$obj->upperCamel()}Controller.php",
        'clear_comment' => false,
    ],
    'home_api_controller' => [
        'path'          => "app/Http/Controllers/{$obj->upperCamel()}/",
        'filename'      => "{$obj->upperCamel()}ApiController.php",
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
    'test_controller' => [
        'path'          => "tests/app/Feature/Http/Controllers/",
        'filename'      => "{$obj->upperCamel()}ControllerTest.php",
        'clear_comment' => false,
    ],
    'test_service' => [
        'path'          => "tests/app/Feature/Services/",
        'filename'      => "{$obj->upperCamel()}ServiceTest.php",
        'clear_comment' => false,
    ],
    'database_factory' => [
        'path'          => "app/database/factories/",
        'filename'      => "{$obj->upperCamel()}Factory.php",
        'clear_comment' => false,
    ],
  
    //
    'kos_repository' => [
        'path'          => "app/Repositories",
        'filename'      => "{$obj->upperCamel()}Repository.php",
        'clear_comment' => false,
    ],
    'kos_service' => [
        'path'          => "app/Services",
        'filename'      => "{$obj->upperCamel()}Service.php",
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