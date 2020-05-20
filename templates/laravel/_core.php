<?php

function assingTemplate($template)
{
    /* --------------------------------------------------------------------------------
        variable setting
    -------------------------------------------------------------------------------- */
    /*
    foreach ( $status as $adoField ) {
        if (     $adoField->name == 'user_id' )    { $haveUser       = 1;    }
        elseif ( $adoField->name == 'blog_id' )    { $haveBlog       = 1;    }
        elseif ( $adoField->name == 'properties' ) { $haveProperties = 1;    }
    }
    unset($adoField);
    */

    /* --------------------------------------------------------------------------------
        add to templates
    -------------------------------------------------------------------------------- */
    $obj = new NamePrototype(SessionManager::projectName());
    $mod = new NamePrototype(SessionManager::daoName());

    //--------------------------------------------------------------------------------
    foreach (getTableColumnsStatus() as $name => $typeObject) {
        $nameObject = new NamePrototype($name);
        $tab[$nameObject->lowerCamel()] = [
            'name' => $nameObject,
            'ado'  => $typeObject,
        ];
    }

    $template->assign('mod', $mod);
    $template->assign('obj', $obj);
    $template->assign('tab', $tab);
    $template->assign('today', date("Ymd"));
    $template->assign('isApp', true);
    $template->assign('isModule', false);
    return $template;
}

function show_debug_information(
    $mod = null,
    $obj = null,
    $tab = null)
{
    if ($mod) {
        echo '$mod' . " => ";
        print_r($mod);
        echo "\n";
    }

    if ($obj) {
        echo '$obj' . " => ";
        print_r($obj);
        echo "\n";
    }

    if ($tab) {
        echo '$tab' . " => ";
        print_r($tab);
        echo "\n";
    }

    // print_r( getTableColumnsStatus() ); echo "\n";
    // print_r( getProjectName()        ); echo "\n";
    // print_r( getDaoName()            ); echo "\n";
    // print_r( getTable()              ); echo "\n";
}
