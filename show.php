<?php
/**
 *  show.php 跟 index.php 不同的是在於
 *      show.php 用的是 php 上色
 *      index.php 用的是 js 上色
 */
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
    $template->display(getProjectKey() . '/' . $page . '.tpl');
    $showCode = ob_get_contents();
ob_end_clean();
// $showCode = str_replace('/##/', '', $showCode );


ob_start();
    highlight_string( $showCode );
    $showCode = ob_get_contents();
ob_end_clean();




echo $template->fetch(getProjectKey().'/_header.tpl' ) ."<br />\n";
echo str_replace('<code>', '<code style="Font-family:dina,細明體;font-size:13px;">', $showCode );


//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
//