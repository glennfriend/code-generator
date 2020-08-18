<?php
//--------------------------------------------------------------------------------
// init
//--------------------------------------------------------------------------------
include_once('library/init.php');

if (!sessionCheck()) {
    header('location: session-control.php');
    exit;
}

//--------------------------------------------------------------------------------
// menu & validate
//--------------------------------------------------------------------------------
$page = get('t');
$menu = getMenu($page);
if (!$menu) {
    redirect("?t=dbobject");
}

//--------------------------------------------------------------------------------
// data
//--------------------------------------------------------------------------------
$templateManager = new TemplateManager($menu);
$template = $templateManager->genSmarty();

$lang = getLangType($menu);

//--------------------------------------------------------------------------------
// output
//--------------------------------------------------------------------------------
headerOutput();

ob_start();
    $template->display(SessionManager::projectKey() . '/' . $page . '.tpl');
    $showCode = ob_get_contents();
ob_end_clean();
//echo $showCode;


//--------------------------------------------------------------------------------
// create file
//--------------------------------------------------------------------------------

include_once('library/file.class.php');
$createFileDirectory = "tmp_create/";

$result = file::createDir(  $createFileDirectory.$menu['path'], $mode1 = 0777, $mode2 = 'www-data' );
if( $result ) {
    echo '<span style="color:green">create directory success</span>';
} else {
    echo '<span style="color:red">create directory error</span>';
}
echo "<br />\n";

$result = file::createFile( $createFileDirectory.$menu['path'], $menu['filename'], $showCode, true);
echo $createFileDirectory.$menu['path'];
if( $result ) {
    echo '<span style="color:green">create file success</span>';
} else {
    echo '<span style="color:red">create file error</span>';
}
echo "<br />\n";

file::chMod( $createFileDirectory.$menu['path'].$menu['filename'], 0777 );
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