<?php

$config['base'] = dirname(__DIR__);

$config['list'] = [
    'key'       => ['yii', 'phalcon'],
    'databases' => ['users', 'search_user_facebook_mix'],
    /**
     *  完全自訂的地方
     */
    'items' => [
        [
            'db'        => 'test',
            'object'    => 'user',
            'dao'       => 'users',
            'table'     => 'users',
        ],[
            'db'        => 'test',
            'object'    => 'config',
            'dao'       => 'configs',
            'table'     => 'configs',
        ],[
            'db'        => 'test',
            'object'    => 'article',
            'dao'       => 'articles',
            'table'     => 'test'.'articles',
        ],
    ],
];
// 以上在設定時請使用全小寫字母
// object 跟 dao 的名稱如有分隔請使用 _ 符號

//
$config['database'] = Array(
    'type'      => 'mysqli',
    'server'    => 'localhost',
    'user'      => 'root',
    'password'  => '',
);
