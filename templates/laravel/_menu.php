<?php

$obj = new NamePrototype(SessionManager::projectName());
$mod = new NamePrototype(SessionManager::daoName());
$today = date("Y_m_d");

return [

    'eloquent'      => [
        'path'          => "app/Entities/",
        'filename'      => "{$obj->upperCamel()}Eloquent.php",
        'clear_comment' => false,
    ],
    'eloquent_test' => [
        'path'     => "tests/app/Unit/Entities/",
        'filename' => "{$obj->upperCamel()}Test.php",
    ],

    'factories' => [
        'path'     => "database/factories/",
        'filename' => "{$obj->upperCamel()}Factory.php",
    ],

    'json_resource'        => [
        'path'     => "app/Http/Resources/",
        'filename' => "{$obj->upperCamel()}Resource.php",
    ],
    'migration'            => [
        'path'     => "app/database/migrations/",
        'filename' => $today . "_000001_create_{$mod->lower('_')}_table.php",
    ],
    'migration_view'       => [
        'path'     => "app/database/migrations/",
        'filename' => $today . "_000001_create_{$mod->lower('_')}_view.php",
    ],
    'value_object'         => [
        'path'     => "app/Molds/",
        'filename' => "{$obj->upperCamel()}.php",
    ],
    'model'                => [
        'path'     => "app/Molds/",
        'filename' => "{$mod->upperCamel()}.php",
    ],
    'model_extend'         => [
        'path'     => "app/Molds/",
        'filename' => "{$mod->upperCamel()}.php",
    ],
    'search_table'         => [
        'path'     => "app/Molds/SearchTable/",
        'filename' => "{$mod->upperCamel()}.php",
    ],

    //
    'locale'               => [
        'path'     => "resource/locale/",
        'filename' => "zh_tw.php",
    ],

    // controller
    'home_controller'      => [
        'path'     => "app/Http/Controllers/{$obj->upperCamel()}/",
        'filename' => "{$obj->upperCamel()}Controller.php",
    ],
    'home_controller_test' => [
        'path'     => "tests/app/Feature/Http/Controllers/",
        'filename' => "{$obj->upperCamel()}ControllerTest.php",
    ],

    'home_api_controller' => [
        'path'     => "app/Http/Controllers/Api/{$obj->upperCamel()}/",
        'filename' => "{$obj->upperCamel()}ApiController.php",
    ],

    // job
    'job_job'             => [
        'path'     => "app/Jobs/",
        'filename' => "{$obj->upperCamel()}Job.php",
    ],
    'job_job_test'        => [
        'path'     => "tests/app/Feature/jobs/",
        'filename' => "{$obj->upperCamel()}JobTest.php",
    ],

    'job_param'               => [
        'path'     => "app/DataTransferObjects/",
        'filename' => "{$obj->upperCamel()}Params.php",
    ],
    'job_work'                => [
        'path'     => "app/Services/Works/",
        'filename' => "{$obj->upperCamel()}Work.php",
    ],

    // business layer
    'business_service'        => [
        'path'     => "app/Service/{$obj->upperCamel()}/",
        'filename' => "{$obj->upperCamel()}Service.php",
    ],
    'business_helper'         => [
        'path'     => "app/Service/{$obj->upperCamel()}/",
        'filename' => "{$obj->upperCamel()}Helper.php",
    ],
    'code_snippet'         => [
        'path'     => "app/",
        'filename' => "code_snippet.php",
    ],
    


    // js
    'js'                      => [
        'path'     => "home/admin/dist/{$obj}/",
        'filename' => "main.js",
    ],
    'js_object'               => [
        'path'     => "home/admin/dist/{$obj}/",
        'filename' => "{$obj}.js",
    ],

    // view
    'view_index_aggrid'       => [
        'path'     => "resources/views/admin/xxxxxx/{$obj->lower('-')}/",
        'filename' => "index.blade.php",
    ],
    'view_index'              => [
        'path'     => "resources/views/{$obj}/views/",
        'filename' => "home.index.phtml",
    ],
    'view_create'             => [
        'path'     => "resources/views/{$obj}/views/",
        'filename' => "home.create.phtml",
    ],
    'view_edit'               => [
        'path'     => "resources/views/{$obj}/views/",
        'filename' => "home.edit.phtml",
    ],

    // test
    'test_data'               => [
        'path'     => "tests/app/Data/Controllers/",
        'filename' => "{$obj->lower('_')}.json",
    ],

    // kos flow
    'kos_controller_api'      => [
        'path'     => "app/Http/Controllers/Api/{$obj->upperCamel()}/",
        'filename' => "{$obj->upperCamel()}ApiController.php",
    ],
    'kos_controller_api_test' => [
        'path'     => "tests/app/Feature/Api/",
        'filename' => "{$obj->upperCamel()}ApiTest.php",
    ],


    'kos_request'      => [
        'path'     => "app/Http/Requests/{$obj->upperCamel()}/",
        'filename' => "{$obj->upperCamel()}Request.php",
    ],
    'kos_request_test' => [
        'path'     => "tests/app/Http/Requests/",
        'filename' => "{$obj->upperCamel()}RequestTest.php",
    ],
    'kos_rule'      => [
        'path'     => "app/Rules/{$obj->upperCamel()}/",
        'filename' => "{$obj->upperCamel()}Rule.php",
    ],
    'kos_repository'   => [
        'path'     => "app/Repositories/",
        'filename' => "{$obj->upperCamel()}Repository.php",
    ],

    'kos_service'      => [
        'path'     => "app/Services",
        'filename' => "{$obj->upperCamel()}Service.php",
    ],
    'kos_service_test' => [
        'path'     => "tests/app/Feature/Services/",
        'filename' => "{$obj->upperCamel()}ServiceTest.php",
    ],

    'kos_use_case' => [
        'path'     => "app/UseCases",
        'filename' => "{$obj->upperCamel()}UseCase.php",
    ],
    'kos_use_case_test' => [
        'path'     => "tests/app/Feature/UseCases",
        'filename' => "{$obj->upperCamel()}UseCaseTest.php",
    ],

    'kos_provider'     => [
        'path'     => "app/Providers",
        'filename' => "{$obj->upperCamel()}Provider.php",
    ],

    //
    'kos_console'      => [
        'path'     => "app/Console",
        'filename' => "{$obj->upperCamel()}Console.php",
    ],
    'kos_console_test' => [
        'path'     => "tests/app/Unit/Console",
        'filename' => "{$obj->upperCamel()}ConsoleTest.php",
    ],

    // readme
    'readme'           => [
        'path'     => "app/",
        'filename' => "README.md",
    ],

    // for debug
    'debug_only'       => [
        'path'     => "app/",
        'filename' => "Debug.php",
    ],

];

//