<?php
/**
 *  show.php 跟 index.php 不同的是在於
 *      show.php 用的是 php 上色
 *      index.php 用的是 js 上色
 */
//--------------------------------------------------------------------------------
// kernel
//--------------------------------------------------------------------------------
include_once('config/config.inc.php');
include_once('library/helper.php');

session_start();
if ( !sessionCheck() ) {
    header('location: session-control.php');
    exit;
}

$projectKey = $_SESSION['projectKey'];
$objectName = $_SESSION['useObject'];
$daoName    = $_SESSION['useDao'];
$table      = $_SESSION['useTable'];

$db = getDbConnect( $config['database'] , $_SESSION['useDb'] );
$status = getTableColumnsStatus( $db, $table );  // get meta columns
//echo '<pre>';  print_r($status);  exit;

//--------------------------------------------------------------------------------
// request
//--------------------------------------------------------------------------------
$code_generator_template = get('t', 'dbobject');

//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
/*
$rs = $db->Execute("select * from {$prefix}epapers where id>=1 LIMIT 3");
while ($row = $rs->FetchRow()) {
    print_r($row);
    echo '----------------';
}
*/


//--------------------------------------------------------------------------------
// template
//--------------------------------------------------------------------------------
$template = getTemplate();

// template program
include_once( 'templates/'. $projectKey .'/_code.php');

// create config
include_once( 'templates/'. $projectKey .'/_create_config.inc.php' );
$cf = $createConfig[ $code_generator_template ];
$template->assign('cf', $cf );


//--------------------------------------------------------------------------------
// output
//--------------------------------------------------------------------------------
headerOutput();

ob_start();
    $template->display( $projectKey.'/'.$code_generator_template.'.tpl' );
    $showCode = ob_get_contents();
ob_end_clean();
//$showCode = str_replace('/##/', '', $showCode );


ob_start();
    highlight_string( $showCode );
    $showCode = ob_get_contents();
ob_end_clean();




echo $template->fetch( $projectKey.'/_header.tpl' ) ."<br />\n";
echo str_replace('<code>', '<code style="Font-family:dina,細明體;font-size:13px;">', $showCode );


//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
//