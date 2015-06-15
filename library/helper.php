<?php

include_once('library/adodb-master/adodb.inc.php');
include_once('library/smarty/libs/Smarty.class.php');


/*
    get db connect 
*/
function getDbConnect( $databaseConfig, $databaseName ) {
    $db = NewADOConnection( $databaseConfig['type'] );
    $db->Connect(
        $databaseConfig['server'],
        $databaseConfig['user'],
        $databaseConfig['password'],
        $databaseName
    );
    return $db;
}


/*
    取得所需資料表的格式
    P.S. 
        若要取得 index 可以使用 $db->MetaIndexes( $table )

*/
function getTableColumnsStatus( $db, $table )
{
    $status = $db->MetaColumns( $table );
    if( !$status ) {
        die(' 無法取得所需資料表的格式, 請確定名稱是否設定錯誤! ');
    }

    /*
        陣列的 key 是大寫
        為了方便 mapping
        將其 key 轉化為小寫
    */
    foreach( $status as $name => $obj ) {
        unset( $status[ $name ] );
        $status[ strtolower($name) ] = $obj;
    }

    return $status;

}


/*
    取得使用的樣版
*/
function getTemplate( $isDebug = false ) {
    $template = new Smarty;
    $template->debugging    = $isDebug;
    $template->caching      = false;
    $template->cache_lifetime = 0;

    $template->setTemplateDir('./templates');
    $template->compile_dir     = './tmp/';
    $template->cache_dir       = './tmp/template_cache/';
    //$template->left_delimiter  = '{';
    //$template->right_delimiter = '}';

    // 不要快取 template
    $template->clearCompiledTemplate();

    return $template;
}




//