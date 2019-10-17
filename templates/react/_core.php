<?php

function assingTemplate($template)
{
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
    $template->left_delimiter  = '{{';
    $template->right_delimiter = '}}';
    return $template;
}

function show_debug_information()
{

}
