<?php

date_default_timezone_set('Asia/Taipei');
ini_set( 'date.timezone', 'Asia/Taipei');

error_reporting(E_ALL & ~E_NOTICE);
ini_set('html_errors','On');
ini_set('display_errors','On');

include_once('SessionManager.class.php');
SessionManager::init();

require_once(__DIR__.'/../composer/vendor/autoload.php');
include_once('Inflector.class.php');
include_once('TemplateManager.class.php');
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




/**
 *
 */
function includeConfig()
{
    return include(__DIR__.'/../config/config.inc.php');
}


/**
 *  check all basic session name
 */
function sessionCheck()
{
    if (! SessionManager::projectKey()) {
        return false;
    }
    if (! SessionManager::projectName()) {
        return false;
    }
    if (! SessionManager::daoName()) {
        return false;
    }
    if (! SessionManager::table()) {
        return false;
    }
    if (! SessionManager::database()) {
        return false;
    }

    return true;
}

/*
    get db connect
*/
function getDbConnect()
{
    if (! SessionManager::database()) {
        die('db connect error!');
    }

    $config = includeConfig();
    // print_r($config); exit;
    $databases = $config['database'];

    //
    $db = NewADOConnection($databases['type']);
    $db->Connect(
        $databases['server'],
        $databases['user'],
        $databases['password'],
        SessionManager::database()
    );
    return $db;
}

/**
 *  取得 menu
 *  依照 session 設定取得指定的 menu option
 */
function getMenu($page)
{
    $menu = include('templates/'. SessionManager::projectKey() .'/_menu.php');

    if (!isset($menu[$page])) {
        return null;
    }
    return $menu[$page];
};

/**
 *
 */
function getMenuFirstKey()
{
    $menu = include('templates/'. SessionManager::projectKey() .'/_menu.php');
    return key($menu);
};

/**
 *  get lang type by menu
 */
function getLangType($menu)
{
    if (isset($menu['lang_type'])) {
        return $menu['lang_type'];
    }
    return 'php';
}


/*
    取得所需資料表的格式
    P.S.
        若要取得 index 可以使用 $db->MetaIndexes( $table )

*/
function getTableColumnsStatus()
{
    $db     = getDbConnect();
    $table  = SessionManager::table();
    $status = $db->MetaColumns($table);
    if (!$status) {
        die('無法取得所需資料表的格式, 請確定名稱是否設定錯誤!');
    }

    /*
        陣列的 key 是大寫
        為了方便 mapping
        將其 key 轉化為小寫
    */
    foreach ($status as $name => $obj) {
        unset($status[$name]);
        $status[strtolower($name)] = $obj;
    }

    return $status;
}

/**
 *
 */
function redirect($url)
{
    header('location: '. $url);
    exit;
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

//
function headerOutput()
{
    $config = includeConfig();
    include $config['base'] . '/library/header.tpl.php';
}




//