<?php

function assingTemplate($template)
{
    global $st;

    $obj = new NamePrototype(getProjectName());
    $mod = new NamePrototype(getDaoName());

    //--------------------------------------------------------------------------------
    $i = 0;
    foreach (getTableColumnsStatus() as $name => $typeObject) {
        $nameObject = new NamePrototype( $name );
        $tab[ $nameObject->lowerCamel() ] = array(
            'name' => $nameObject,
            'ado'  => $typeObject,
        );
    }

    $template->assign('mod', $mod);
    $template->assign('obj', $obj);
    $template->assign('tab', $tab);
    return $template;
}