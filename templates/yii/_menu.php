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

    'model' => Array(
        'path'          => "protected/models/",
        'filename'      => "{$oName3}.php",
        'clear_comment' => false,
    ),
    'mapper' => Array(
        'path'          => "protected/models/",
        'filename'      => "{$mName3}.php",
        'clear_comment' => false,
    ),

    // controller
    'adminController' => Array(
        'path'          => "protected/controllers/",
        'filename'      => "Admin{$oName3}Controller.php",
        'clear_comment' => false,
    ),

    // js
    'js' => Array(
        'path'          => "js/pages/",
        'filename'      => "Admin{$oName3}.js",
        'clear_comment' => false,
    ),

    // view
    'list_view' => Array(
        'path'          => "protected/views/admin{$oName3}/",
        'filename'      => "list.php",
        'clear_comment' => false,
    ),
    'new_view' => Array(
        'path'          => "protected/views/admin{$oName3}/",
        'filename'      => "new.php",
        'clear_comment' => false,
    ),
    'edit_view' => Array(
        'path'          => "protected/views/admin{$oName3}/",
        'filename'      => "edit.php",
        'clear_comment' => false,
    ),

    // old
    'old_record' => array(
        'path'          => "protected/models/record/",
        'filename'      => "{$mName3}Record.php",
        'clear_comment' => false,
    ),

];

//