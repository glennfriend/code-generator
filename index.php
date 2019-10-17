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
    $firstKey = getMenuFirstKey();
    redirect("?t=" . $firstKey);
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


echo '<div style="float:right;"><a href="session-control.php">[change]</a></div>';
echo $template->fetch(SessionManager::projectKey() . '/_header.tpl');
echo "<br />\n";
$showCode = str_replace(
    Array('<','>'),
    Array('&lt;','&gt;'),
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



