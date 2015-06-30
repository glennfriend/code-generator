<?php
//--------------------------------------------------------------------------------
// kernel
//--------------------------------------------------------------------------------
include_once('config/config.inc.php');
include_once('library/helper.php');
session_start();
changeProcess( get('change'), get('val') );

//--------------------------------------------------------------------------------
// output
//--------------------------------------------------------------------------------
headerOutput();

$focus = false;
foreach ( $config['list']['key'] as $key ) {
    if ( isset($_SESSION['projectKey']) ) {
        $focus = ($key == $_SESSION['projectKey']);
    }
    echo url($key, $focus);
    echo " | ";
}
echo '
    <div style="float:right;">
        [<a href="./">index.php</a>]
        [<a href="search-table.php">Search Table</a>]
    </div>
';
echo "<br/><br/>";

if ( isset($_SESSION['projectKey']) ) {
    $projectKey = $_SESSION['projectKey'];
    if ( isset($config['list'][$projectKey]) ) {

        foreach ( $config['list'][$projectKey] as $item ) {
            $focus = false;
            if ( isset($_SESSION['useObject']) ) {
                $focus = ($item['object'] == $_SESSION['useObject']);
            }
            echo url2($item, $focus);
        }
        echo "<br/>\n";

    }
}

echo '<pre>SESSION - ';
print_r($_SESSION);
//print_r($config);
exit;


/**
 *  對代入的特殊指令作儲存
 */
function changeProcess( $change, $value )
{
    $change = strtolower($change);
    $value  = preg_replace("/[^a-z0-9,_]+/", '', strtolower($value) );
    if ( !$change || !$value ) {
        return;
    }

    switch($change)
    {
        case "key":
            $_SESSION['projectKey'] = $value;
            unset($_SESSION['useDb']);
            unset($_SESSION['useObject']);
            unset($_SESSION['useDao']);
            unset($_SESSION['useTable']);
            break;
        case "group":
            list($db,$object,$dao,$table) = explode(',',$value);
            $_SESSION['useDb']      = $db;
            $_SESSION['useObject']  = $object;
            $_SESSION['useDao']     = $dao;
            $_SESSION['useTable']   = $table;
            break;
    }
}

function url($key, $focus=false )
{
    $baseName = basename(__FILE__);

    $style = "color: black;";
    if ( $focus ) {
        $style = "color: green;";
    }

    return <<<EOD
<a style="{$style}" href="{$baseName}?change=key&val={$key}">{$key}</a>
EOD;
}

function url2($item, $focus=false )
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
        $style = "color: green;";
    }

    return <<<EOD
<a style="{$style}" href="{$baseName}?change=group&val={$value}">{$item['object']}</a>
&raquo; {$show}
EOD;
}

