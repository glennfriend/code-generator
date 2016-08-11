<?php
/**
 *  程式會讀取你的資料庫
 *  開頭為 "search_" 的都會認定為 search table
 *  為此建立 sample source code
 *
 */
//--------------------------------------------------------------------------------
// init
//--------------------------------------------------------------------------------
include_once('library/init.php');

if (!sessionCheck()) {
    header('location: session-control.php');
    exit;
}

$_SESSION['projectKey'] = 'search-table';
$prefix = 'search_';

//--------------------------------------------------------------------------------
// table process
//--------------------------------------------------------------------------------
$searchTables = array();
foreach (getDbConnect()->MetaTables() as $table) {
    if ($prefix === substr($table,0,7)) {
        $searchTables[] = $table;
    }
}
if (!$searchTables) {
    die('no any search table');
}


//--------------------------------------------------------------------------------
// request search table
//--------------------------------------------------------------------------------
$st = get('st');
if (!$st) {
    foreach ($searchTables as $st) {
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
$page = get('t', 'search');

//--------------------------------------------------------------------------------
// template
//--------------------------------------------------------------------------------
$menu = getMenu('search');

$templateManager = new TemplateManager($menu);
$template = $templateManager->genSmarty();
$template->assign('st', $st);

//--------------------------------------------------------------------------------
// output
//--------------------------------------------------------------------------------
headerOutput();

$lang = 'php';

ob_start();
    $template->display( 'search-table/'.$page.'.tpl' );
    $showCode = ob_get_contents();
ob_end_clean();

echo '<div style="float:right;"><a href="session-control.php">[change]</a></div>';
echo $template->fetch('search-table/_header.tpl');
echo "<br />\n";
$showCode = str_replace(
    Array('<', '>'),
    Array('&lt;', '&gt;'),
    $showCode
);

echo <<<EOD
<link type="text/css" rel="stylesheet" href="dist/shjs/css/sh_basic.css">
<script type="text/javascript" src="dist/shjs/doc/style.js"></script>
<script type="text/javascript" src="dist/shjs/sh_main.min.js"></script>
<script type="text/javascript" src="dist/shjs/lang/sh_{$lang}.js"></script>
<body onload="sh_highlightDocument();">
<pre id="codePre" class="sh_{$lang}">{$showCode}</pre>
</body>
EOD;




//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
//