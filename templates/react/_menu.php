<?php

$obj = new NamePrototype(SessionManager::projectName());
$mod = new NamePrototype(SessionManager::daoName());
$today = date("Y_m_d");

return [

    'basic_form' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}Section.tsx",
        'clear_comment' => false,
        //'lang_type'     => 'javascript',
    ],

    // component
    'component_select' => [
        'path'          => "modules/{$obj->lower('-')}/compoments/",
        'filename'      => "{$obj->upperCamel()}SelectSection.tsx",
        'clear_comment' => false,
    ],

    // api
    'modal_show_content_by_api' => [
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