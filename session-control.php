<?php
//--------------------------------------------------------------------------------
// init
//--------------------------------------------------------------------------------
include_once('library/init.php');

changeProcess(get('change'), get('val'));

//--------------------------------------------------------------------------------
// output
//--------------------------------------------------------------------------------
headerOutput();
showTopMenu();

echo '
<br><br>
<table id="controlTable" cellpadding="10" cellspacing="0">
    <tbody>
        <tr>
            <td style="width: 500px;">'
                . showTable()
            . '</td>
            <td style="width: 500px;">'
                . showDatabase()
                . showSession()
           . '</td>
        </tr>
    </tbody>
</table>
';

echo "<br/>\n";
echo "<hr/>\n";
echo showCustom();

exit;


/**
 *  對代入的特殊指令作儲存
 */
function changeProcess( $change, $value )
{
    $change = strtolower($change);

    // NOTE: 有些 db name, table name 有可能是大寫, 所以這裡不強迫轉成小寫
    $value = preg_replace("/[^a-zA-Z0-9,_-]+/", '', $value );
    if (! $change || ! $value) {
        return;
    }

    switch ($change)
    {
        case "key":
            SessionManager::set('projectKey', $value);
            /*
            SessionManager::remove('useDb');
            SessionManager::remove('useObject');
            SessionManager::remove('useDao');
            SessionManager::remove('useTable');
            */
            break;

        case "group":
            SessionManager::set('useDb',     null);
            SessionManager::set('useObject', null);
            SessionManager::set('useDao',    null);
            SessionManager::set('useTable',  null);
            $list = explode(',', $value);
            if (isset($list[0])) {  SessionManager::set('useDb',        $list[0]); }
            if (isset($list[1])) {  SessionManager::set('useObject',    $list[1]); }
            if (isset($list[2])) {  SessionManager::set('useDao',       $list[2]); }
            if (isset($list[3])) {  SessionManager::set('useTable',     $list[3]); }
            break;

    }

}

function url($key, $focus=false)
{
    $baseName = basename(__FILE__);

    $style = "color: black;";
    if ($focus) {
        $style = "color: red;";
    }

    return <<<EOD
<a style="{$style}" href="{$baseName}?change=key&val={$key}">{$key}</a>
EOD;
}

function groupUrl($show, $key, $focus)
{
    $baseName = basename(__FILE__);

    $style = "color: black;";
    if ($focus) {
        $style = "color: red;";
    }

    return <<<EOD
<a style="{$style}" href="{$baseName}?change=group&val={$key}">{$show}</a>
EOD;
}

function customUrl($item, $focus=false )
{
    $baseName = basename(__FILE__);
    $show   = <<<EOD
<pre>
    [db]     => {$item['db']}
    [dao]    => {$item['dao']}
    [table]  => {$item['table']}</pre>
EOD;
    $value  = join(',', $item);

    $style = "color: black;";
    if ( $focus ) {
        $style = "color: red;";
    }

    return <<<EOD
<a style="{$style}" href="{$baseName}?change=group&val={$value}">{$item['object']}</a>
&raquo; {$show}
EOD;
}

// --------------------------------------------------------------------------------
// show
// --------------------------------------------------------------------------------

function showTopMenu()
{
    $config = includeConfig();
    $focus = false;

    foreach ( $config['list']['key'] as $key ) {
        if (SessionManager::projectKey()) {
            $focus = ($key == SessionManager::projectKey());
        }
        echo url($key, $focus);
        echo "&nbsp; ";
    }
    echo '
        <div style="float:right;">
            [<a href="./">index.php</a>]
        </div>
    ';
}

function showSession()
{
    $show  = 'SESSION &raquo;';
    $show .= '<pre>';
    $show .=    print_r($_SESSION, true);
    $show .= '</pre>';
    return $show;
}

function showDatabase()
{
    $config = includeConfig();
    $show = "Database &raquo;<br><br>";

    foreach ($config['list']['databases'] as $databaseName) {

        $focus = (
            SessionManager::database() &&
            $databaseName === SessionManager::database()
        );

        if ($focus) {
            $show .= groupUrl($databaseName, $databaseName, true);
        }
        else {
            $show .= groupUrl($databaseName, $databaseName, false);
        }
        $show .= '<br>';
    }

    $show .= '<br>';
    return $show;
}

function showTable()
{
    $show = "Table &raquo;<br><br>";
    if (SessionManager::database()) {

        $db = getDbConnect();
        $allTables = (array) $db->MetaTables();
        foreach ($allTables as $table) {

            $objectName = Cake_Utility_Inflector::singularize($table);
            $daoName    = Cake_Utility_Inflector::pluralize($objectName);

            $focus = (
                SessionManager::table() &&
                $table === SessionManager::table()
            );
            $key = SessionManager::database() . ",{$objectName},{$daoName},{$table}";

            if ($focus) {
                $show .= groupUrl($table, $key, true);
                $show .= '<br>';
                $show .= str_repeat("&nbsp;", 4);
                $show .= 'dao &nbsp;&nbsp; &raquo; ' . $objectName;
                $show .= '<br>';
                $show .= str_repeat("&nbsp;", 4);
                $show .= 'object &raquo; ' . $daoName;
                $show .= '<br>';
            }
            else {
                $show .= groupUrl($table, $key, false);
            }

            $show .= '<br>';

        }
    }

    $show .= '<br>';

    return $show;
}

function showCustom()
{
    $config = includeConfig();
    $show = "[Custom]<br><br>";

    foreach ( $config['list']['items'] as $item ) {
        $focus = false;
        if (SessionManager::projectName()) {
            $focus = ($item['object'] == SessionManager::projectName());
        }
        $show .= customUrl($item, $focus);
    }

    $show .= '<br>';
    return $show;
}

