<?php

$nameObject = new NamePrototype( getProjectName() ); // model object
$oName1 = $nameObject->lower();
$oName2 = $nameObject->lowerCamel();
$oName3 = $nameObject->upperCamel();
$oName4 = $nameObject->upper();
$oName5 = $nameObject->lower('_');
$oName6 = $nameObject->upperCamel('_');
$oName7 = $nameObject->upper('_');

//--------------------------------------------------------------------------------
$nameObject = new NamePrototype( getDaoName() ); // mapper
$mName1 = $nameObject->lower();
$mName2 = $nameObject->lowerCamel();
$mName3 = $nameObject->upperCamel();
$mName4 = $nameObject->upper();
$mName5 = $nameObject->lower('_');
$mName6 = $nameObject->upperCamel('_');
$mName7 = $nameObject->upper('_');

return [

    'dbobject' => array(
        'path'          => "protected/models/",
        'filename'      => "{$oName3}.php",
        'clear_comment' => false,
    ),
    'model' => array(
        'path'          => "protected/models/",
        'filename'      => "{$mName3}.php",
        'clear_comment' => false,
    ),
    'record' => array(
        'path'          => "protected/models/record/",
        'filename'      => "{$mName3}Record.php",
        'clear_comment' => false,
    ),

    //
    'locale' => array(
        'path'          => "protected/libraries/locale/locale/",
        'filename'      => "locale_zh_TW.php",
        'clear_comment' => false,
    ),

    // controller
    'homeController' => array(
        'path'          => "protected/modules/{$oName1}/controllers/",
        'filename'      => "HomeController.php",
        'clear_comment' => false,
    ),

    // js
    'js' => array(
        'path'          => "admin/js/modules/",
        'filename'      => "Admin{$oName3}.js",
        'clear_comment' => false,
    ),

    // view
    'index_view' => array(
        'path'          => "protected/modules/{$oName1}/views/home/",
        'filename'      => "index.php",
        'clear_comment' => false,
    ),
    'new_view' => array(
        'path'          => "protected/modules/{$oName1}/views/home/",
        'filename'      => "new.php",
        'clear_comment' => false,
    ),
    'edit_view' => array(
        'path'          => "protected/modules/{$oName1}/views/home/",
        'filename'      => "edit.php",
        'clear_comment' => false,
    ),

];
