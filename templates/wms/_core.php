<?php

function assingTemplate($template)
{
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
    return $template;
}
