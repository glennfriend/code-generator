<?php

$obj = new NamePrototype(SessionManager::projectName());
$mod = new NamePrototype(SessionManager::daoName());
$today = date("Y_m_d");

return [

    // main
    'my_page' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}Page.tsx",
        'clear_comment' => false,
    ],
    'my_board' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}Board.tsx",
        'clear_comment' => false,
    ],
    'my_list' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}List.tsx",
        'clear_comment' => false,
    ],
    'my_list_table' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}ListTable.tsx",
        'clear_comment' => false,
    ],
    'my_form' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}Form.tsx",
        'clear_comment' => false,
    ],
    'my_create_form' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}CreateForm.tsx",
        'clear_comment' => false,
    ],
    'my_update_form' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}UpdateForm.tsx",
        'clear_comment' => false,
    ],

    // main
    'my_service' => [
        'path'          => "modules/{$obj->lower('-')}/services/",
        'filename'      => "{$obj->upperCamel()}Service.tsx",
        'clear_comment' => false,
    ],

    // core
    'core_interfaces' => [
        'path'          => "modules/core/compoments/interfaces",
        'filename'      => "App.d.ts",
        'clear_comment' => false,
        //'lang_type'     => 'javascript',
    ],

    //
    'basic_form' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}Section.tsx",
        'clear_comment' => false,
    ],

    // logic component
    'logic_select' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}SelectSection.tsx",
        'clear_comment' => false,
    ],

    // dirty component
    'dirty_select' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/______/",
        'filename'      => "{$obj->upperCamel()}Select.tsx",
        'clear_comment' => false,
    ],
    'dirty_radio' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/______/",
        'filename'      => "{$obj->upperCamel()}Radio.tsx",
        'clear_comment' => false,
    ],
    'dirty_table' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/______/",
        'filename'      => "{$obj->upperCamel()}Table.tsx",
        'clear_comment' => false,
    ],
    'dirty_aggrid' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/______/",
        'filename'      => "{$obj->upperCamel()}Aggrid.tsx",
        'clear_comment' => false,
    ],

    // modal
    'modal_show_content_by_api' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}ShowContentSection.tsx",
        'clear_comment' => false,
    ],
    'modal_show_content_use_table' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}ShowContentSection.tsx",
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