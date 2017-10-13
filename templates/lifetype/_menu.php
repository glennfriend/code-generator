<?php

$nameObject = new NamePrototype( getProjectName() ); // db object
$oName1 = $nameObject->lower();
$oName2 = $nameObject->lowerCamel();
$oName3 = $nameObject->upperCamel();
$oName4 = $nameObject->upper();
$oName5 = $nameObject->lower('_');
$oName6 = $nameObject->upperCamel('_');
$oName7 = $nameObject->upper('_');

//--------------------------------------------------------------------------------
$nameObject = new NamePrototype( getDaoName() ); // model
$mName1 = $nameObject->lower();
$mName2 = $nameObject->lowerCamel();
$mName3 = $nameObject->upperCamel();
$mName4 = $nameObject->upper();
$mName5 = $nameObject->lower('_');
$mName6 = $nameObject->upperCamel('_');
$mName7 = $nameObject->upper('_');

return [

    'dbobject' => Array(
        'path'          => "{$oName1}/class/dao/",
        'filename'      => "{$oName1}.class.php",
        'clear_comment' => false,
    ),
    'model' => Array(
        'path'          => "{$oName1}/class/dao/",
        'filename'      => "{$mName1}.class.php",
        'clear_comment' => false,
    ),
    'plugin' => Array(
        'path'          => "{$oName1}/",
        'filename'      => "plugin{$oName1}.class.php",
        'clear_comment' => false,
    ),
    'helper' => Array(
        'path'          => "{$oName1}/class/helper/",
        'filename'      => "plugin{$oName1}utils.class.php",
        'clear_comment' => false,
    ),

    //
    'locale' => Array(
        'path'          => "{$oName1}/locale/",
        'filename'      => "locale_zh_TW.php",
        'clear_comment' => false,
        ),
    'js' => Array(
        'path'          => "{$oName1}/js/ui/pages/",
        'filename'      => "{$mName1}.js",
        'clear_comment' => false,
        'lang_type'     => 'javascript',
    ),

    // action
    'listaction' => Array(
        'path'          => "{$oName1}/class/action/",
        'filename'      => "pluginedit{$mName1}action.class.php",
        'clear_comment' => false,
    ),
    'newaction' => Array(
        'path'          => "{$oName1}/class/action/",
        'filename'      => "pluginnew{$oName1}action.class.php",
        'clear_comment' => false,
    ),
    'editaction' => Array(
        'path'          => "{$oName1}/class/action/",
        'filename'      => "pluginedit{$oName1}action.class.php",
        'clear_comment' => false,
    ),
    'addaction' => Array(
        'path'          => "{$oName1}/class/action/",
        'filename'      => "pluginadd{$oName1}action.class.php",
        'clear_comment' => false,
    ),
    'updateaction' => Array(
        'path'          => "{$oName1}/class/action/",
        'filename'      => "pluginupdate{$oName1}action.class.php",
        'clear_comment' => false,
    ),
    'deleteaction' => Array(
        'path'          => "{$oName1}/class/action/",
        'filename'      => "plugindelete{$oName1}action.class.php",
        'clear_comment' => false,
    ),

    // view
    'listview' => Array(
        'path'          => "{$oName1}/class/view/",
        'filename'      => "plugin{$mName1}listview.class.php",
        'clear_comment' => false,
    ),
    'newview' => Array(
        'path'          => "{$oName1}/class/view/",
        'filename'      => "pluginnew{$oName1}view.class.php",
        'clear_comment' => false,
    ),
    'editview' => Array(
        'path'          => "{$oName1}/class/view/",
        'filename'      => "pluginedit{$oName1}view.class.php",
        'clear_comment' => false,
    ),

    // template
    'listtemplate' => Array(
        'path'          => "{$oName1}/templates/",
        'filename'      => "edit{$mName1}.template",
        'clear_comment' => false,
        'lang_type'     => 'html',
    ),
    'listtabletemplate' => Array(
        'path'          => "{$oName1}/templates/",
        'filename'      => "edit{$mName1}_table.template",
        'clear_comment' => false,
        'lang_type'     => 'html',
    ),
    //
    'newtemplate' => Array(
        'path'          => "{$oName1}/templates/",
        'filename'      => "new{$oName1}.template",
        'clear_comment' => false,
        'lang_type'     => 'html',
    ),
    'newformtemplate' => Array(
        'path'          => "{$oName1}/templates/",
        'filename'      => "new{$oName1}_form.template",
        'clear_comment' => false,
        'lang_type'     => 'html',
    ),
    //
    'edittemplate' => Array(
        'path'          => "{$oName1}/templates/",
        'filename'      => "edit{$oName1}.template",
        'clear_comment' => false,
        'lang_type'     => 'html',
    ),
    'editformtemplate' => Array(
        'path'          => "{$oName1}/templates/",
        'filename'      => "edit{$oName1}_form.template",
        'clear_comment' => false,
        'lang_type'     => 'html',
    ),

    // tool
    'tooltemplate' => Array(
        'path'          => "tmp/",
        'filename'      => "tmp_tooltemplate.class.php",
        'clear_comment' => false,
    ),
    'csstooltemplate' => Array(
        'path'          => "tmp/",
        'filename'      => "tmp_csstooltemplate.class.php",
        'clear_comment' => false,
    ),

];

