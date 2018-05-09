<?php

function assingTemplate($template)
{
    //--------------------------------------------------------------------------------
    // variable setting
    //--------------------------------------------------------------------------------
    /*
    foreach ( $status as $adoField ) {
        if (     $adoField->name == 'user_id' )    { $haveUser       = 1;    }
        elseif ( $adoField->name == 'blog_id' )    { $haveBlog       = 1;    }
        elseif ( $adoField->name == 'properties' ) { $haveProperties = 1;    }
    }
    unset($adoField);
    */

    //--------------------------------------------------------------------------------
    // add to templates
    //--------------------------------------------------------------------------------
    $obj = new NamePrototype(getProjectName());
    $mod = new NamePrototype(getDaoName());
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


    /*
    echo '<pre style="background-color:#def;color:#000;text-align:left;font-size:10px;font-family:dina,GulimChe;">';
    // print_r( $mod           ); echo "\n";
    // print_r( $obj           ); echo "\n";
    print_r( $tab           ); echo "\n";
    // print_r( getTableColumnsStatus() ); echo "\n";
    // print_r( getProjectName()        ); echo "\n";
    // print_r( getDaoName()            ); echo "\n";
    // print_r( getTable()              ); echo "\n";
    echo "</pre>\n"; exit;
    */


    return $template;
}
