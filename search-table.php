<?php
//--------------------------------------------------------------------------------
// kernel
//--------------------------------------------------------------------------------
include_once('config/config.inc.php');
include_once('library/helper.php');

//--------------------------------------------------------------------------------
// session
//--------------------------------------------------------------------------------
session_start();
if ( !sessionCheck() ) {
    header('location: session_control.php');
    exit;
}

$projectKey = 'search-table';
$objectName = $_SESSION['useObject'];
$daoName    = $_SESSION['useDao'];
$table      = $_SESSION['useTable'];

$db = getDbConnect( $config['database'] , $_SESSION['useDb'] );
$status = getTableColumnsStatus( $db, $table );  // get meta columns
//echo '<pre>';  print_r($status);  exit;

//--------------------------------------------------------------------------------
// table process
//--------------------------------------------------------------------------------
$searchTables = array();
foreach ( $db->MetaTables() as $table ) {
    if ( 'search_' == substr($table,0,7) ) {
        $searchTables[] = $table;
    }
}
if ( !$searchTables ) {
    die('no any search table');
}

//--------------------------------------------------------------------------------
// request search table
//--------------------------------------------------------------------------------
$st = get('st');
if ( !$st ) {
    foreach( $searchTables as $st ) {
        $url = basename(__FILE__) . "?st={$st}&t=search";
        echo '<a href="'. $url .'">'. $st .'</a>';
        echo " | ";
    }
    $url = basename(__FILE__);
    echo '<a href="'. $url .'">reset</a>';
    exit;
}

//--------------------------------------------------------------------------------
// request template
//--------------------------------------------------------------------------------
$code_generator_template = get('t', 'search');

//--------------------------------------------------------------------------------
// template
//--------------------------------------------------------------------------------
$template = getTemplate();

// template program
include_once( 'templates/'. $projectKey .'/_code.php');

// create config
include_once( 'templates/'. $projectKey .'/_create_config.inc.php' );
$cf = $createConfig[ $code_generator_template ];
if( !$cf ) {
    foreach( $createConfig as $key => $theConfig ) {
        $code_generator_template = $key;
        $cf = $theConfig;
        break;
    }
    unset($key,$theConfig);
}
$template->assign('cf', $cf );
$template->assign('st', $st );



//--------------------------------------------------------------------------------
// output
//--------------------------------------------------------------------------------
headerOutput();

if (isset($cf['lang_type'])) {
    $lang = $cf['lang_type'];
}
else {
    $lang = 'php';
}

ob_start();
    $template->display( $projectKey.'/'.$code_generator_template.'.tpl' );
    $showCode = ob_get_contents();
ob_end_clean();

echo '<div style="float:right;"><a href="session-control.php">[change]</a></div>';
echo $template->fetch( $projectKey.'/_header.tpl' );
echo "<br />\n";
$showCode = str_replace( Array('<','>'), Array('&lt;','&gt;'), $showCode );

echo <<<EOD
<link type="text/css" rel="stylesheet" href="js/shjs/css/sh_basic.css">
<script type="text/javascript" src="js/shjs/doc/style.js"></script>
<script type="text/javascript" src="js/shjs/sh_main.min.js"></script>
<script type="text/javascript" src="js/shjs/lang/sh_{$lang}.js"></script>
<body onload="sh_highlightDocument();">
<pre id="codePre" class="sh_{$lang}" style="Font-family:dina,細明體;font-size:13px;margin:0px;padding:0px;">{$showCode}</pre>
</body>
EOD;




//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
//