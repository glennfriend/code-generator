<?php
//--------------------------------------------------------------------------------
// init
//--------------------------------------------------------------------------------
include_once('library/init.php');

changeProcess( get('change'), get('val') );

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
            <td style="width: 300px;">'. showDatabase() .'</td>
            <td style="width: 500px;">'. showTable()    .'</td>
            <td style="width: 300px;">'. showSession()  .'</td>
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
    $value  = preg_replace("/[^a-zA-Z-9,_]+/", '', $value );
    if ( !$change || !$value ) {
        return;
    }

    switch ($change)
    {
        case "key":
            $_SESSION['projectKey'] = $value;
            /*
            unset($_SESSION['useDb']);
            unset($_SESSION['useObject']);
            unset($_SESSION['useDao']);
            unset($_SESSION['useTable']);
            */
            break;

        case "group":
            $_SESSION['useDb']      = null;
            $_SESSION['useObject']  = null;
            $_SESSION['useDao']     = null;
            $_SESSION['useTable']   = null;
            $list = explode(',', $value);
            if (isset($list[0])) {  $_SESSION['useDb']      = $list[0]; }
            if (isset($list[1])) {  $_SESSION['useObject']  = $list[1]; }
            if (isset($list[2])) {  $_SESSION['useDao']     = $list[2]; }
            if (isset($list[3])) {  $_SESSION['useTable']   = $list[3]; }
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
        if ( isset($_SESSION['projectKey']) ) {
            $focus = ($key == $_SESSION['projectKey']);
        }
        echo url($key, $focus);
        echo "&nbsp; ";
    }
    echo '
        <div style="float:right;">
            [<a href="./">index.php</a>]
            [<a href="search-table.php">Search Table</a>]
        </div>
    ';
}

function showSession()
{
    $show  = 'SESSION &raquo;';
    $show .= '<pre style="height: 120px;">';
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
            isset($_SESSION['useDb']) &&
            $databaseName === $_SESSION['useDb']
        );

        // $show .= str_repeat("&nbsp;", 4);
        if ($focus) {
            $show .= groupUrl($databaseName, $databaseName, true);
        }
        else {
            $show .= groupUrl($databaseName, $databaseName, false);
        }
        $show .= '<br>';
    }

    return $show;
}

function showTable()
{
    $show = "Table &raquo;<br><br>";

    if (isset($_SESSION['useDb'])) {

        $db = getDbConnect();
        $tables = $db->MetaTables();
        foreach ($tables as $table) {

            $objectName = Cake_Utility_Inflector::singularize($table);
            $daoName    = $table;

            $focus = (
                isset($_SESSION['useTable']) &&
                $table === $_SESSION['useTable']
            );
            $key = "{$_SESSION['useDb']},{$objectName},{$daoName},{$table}";

            // $show .= str_repeat("&nbsp;", 4);
            if ($focus) {
                $show .= groupUrl($table, $key, true);
                $show .= '<br>';
                $show .= str_repeat("&nbsp;", 4);
                $show .= 'dao &nbsp;&nbsp; &raquo; ' . $objectName;
                $show .= '<br>';
                $show .= str_repeat("&nbsp;", 4);
                $show .= 'object &raquo; ' . $table;
                $show .= '<br>';
            }
            else {
                $show .= groupUrl($table, $key, false);
            }

            $show .= '<br>';

        }

    }

    return $show;
}

function showCustom()
{
    $config = includeConfig();
    $show = "[Custom]<br><br>";

    foreach ( $config['list']['items'] as $item ) {
        $focus = false;
        if ( isset($_SESSION['useObject']) ) {
            $focus = ($item['object'] == $_SESSION['useObject']);
        }
        $show .= customUrl($item, $focus);
    }
    return $show;
}

