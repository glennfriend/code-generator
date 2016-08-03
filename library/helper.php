<?php

date_default_timezone_set('Asia/Taipei');
ini_set( 'date.timezone', 'Asia/Taipei');

require_once(__DIR__.'/../composer/vendor/autoload.php');

include_once('NamePrototype.class.php');
/*
    $projectNameType1 = 'booksadmin';   // 全小寫
    $projectNameType2 = 'booksAdmin';   // 開頭小寫
    $projectNameType3 = 'BooksAdmin';   // 開頭大寫
    $projectNameType4 = 'BOOKSADMIN';   // 全大寫
    $projectNameType5 = 'books_admin';  // (帶底線) 全小寫
    $projectNameType6 = 'Books_Admin';  // (帶底線) 開頭大寫
    $projectNameType7 = 'BOOKS_ADMIN';  // (帶底線) 全大寫
*/


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

//
function headerOutput()
{
    echo <<<EOD
<meta http-equiv="Content-Language" content="zh-tw" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
EOD;
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

*/
function sessionCheck()
{
    if ( !isset($_SESSION['projectKey']) ) {
        return false;
    }
    //if ( !isset($_SESSION['projectType']) ) {
    //    return false;
    //}
    if ( !isset($_SESSION['useDb']) ) {
        return false;
    }
    if ( !isset($_SESSION['useObject']) ) {
        return false;
    }
    if ( !isset($_SESSION['useDao']) ) {
        return false;
    }
    if ( !isset($_SESSION['useTable']) ) {
        return false;
    }
    return true;
}

/*
    取得 _POST or _GET 參數
*/
function get($key, $defaultValue=null)
{
    $key = trim($key);
    if ( isset($_POST[$key]) ) {
        return $_POST[$key];
    }
    elseif ( isset($_GET[$key]) ) {
        return $_GET[$key];
    }
    return $defaultValue;
}

/*
    取得使用的樣版
*/
function getTemplate( $isDebug = false ) {
    $template = new Smarty;
    $template->debugging        = $isDebug;
    $template->caching          = false;
    $template->cache_lifetime   = 0;
    $template->compile_dir      = './tmp/';
    $template->cache_dir        = './tmp/template_cache/';
    $template->setTemplateDir('./templates');
    $template->addPluginsDir('./library/smarty-plugins');
    //$template->left_delimiter  = '{';
    //$template->right_delimiter = '}';

    // 不要快取 template
    $template->clearCompiledTemplate();

    return $template;
}




//