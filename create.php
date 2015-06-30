<?php
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

$db = getDbConnect( $config['database'] , $_SESSION['projectDb'] );
$status = getTableColumnsStatus( $db, $table );  // get meta columns
//echo '<pre>';  print_r($status);  exit;

//--------------------------------------------------------------------------------
// request
//--------------------------------------------------------------------------------
$code_generator_template = get('t', 'dbobject');

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
//echo $showCode;


//--------------------------------------------------------------------------------
// create file
//--------------------------------------------------------------------------------

include_once('library/file.class.php');
$createFileDirectory = "tmp_create/";

$result = file::createDir(  $createFileDirectory.$cf['path'], $mode1 = 0777, $mode2 = 'www-data' );
if( $result ) {
    echo '<span style="color:green">create directory success</span>';
} else {
    echo '<span style="color:red">create directory error</span>';
}
echo "<br />\n";

$result = file::createFile( $createFileDirectory.$cf['path'], $cf['filename'], $showCode, true);
echo $createFileDirectory.$cf['path'];
if( $result ) {
    echo '<span style="color:green">create file success</span>';
} else {
    echo '<span style="color:red">create file error</span>';
}
echo "<br />\n";

file::chMod( $createFileDirectory.$cf['path'].$cf['filename'], 0777 );
if( $result ) {
    echo '<span style="color:green">chmod file success</span>';
} else {
    echo '<span style="color:red">chmod file error</span>';
}
echo "<br />\n";


//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
//