<?php
$config['base'] = dirname(__DIR__);
$config['list'] = [
    'key'       => ['lifetype', 'yii', 'zalora', 'gear', 'wms', 'laravel_static', 'react', 'laravel'],
    'databases' => ['erp', 'crm', 'wms', 'shop', 'site', 'test'],
    /**
     *  完全自訂的地方
     */
    'items' => [
        [
            'db'        => 'test',
            'object'    => 'user_log',
            'dao'       => 'user_logs',
            'table'     => 'user_logs',
        ],[
            'db'        => 'test',
            'object'    => 'user',
            'dao'       => 'users',
            'table'     => 'users',
        ],[
            'db'        => 'test',
            'object'    => 'article',
            'dao'       => 'articles',
            'table'     => 'plog' . 'articles',
        ],
    ],
];
// 以上在設定時請使用全小寫字母
// object 跟 dao 的名稱如有分隔請使用 _ 符號

//
$config['database'] = Array(
    'type'      => 'mysqli',
    'server'    => '127.0.0.1',
  //'server'    => 'localhost',
    'user'      => 'root',
    'password'  => '',
);
/*
// for docker
$config['database'] = Array(
    'type'      => 'mysqli',
    'server'    => '127.0.0.1:8800',
    'user'      => 'root',
    'password'  => 'root',
);
*/

return $config;