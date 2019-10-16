<?php

function assingTemplate($template)
{
    //--------------------------------------------------------------------------------
    // variable setting
    //--------------------------------------------------------------------------------
    $nameObject = new NamePrototype( SessionManager::projectName() ); // db object
    $oName1 = $nameObject->lower();
    $oName2 = $nameObject->lowerCamel();
    $oName3 = $nameObject->upperCamel();
    $oName4 = $nameObject->upper();
    $oName5 = $nameObject->lower('_');
    $oName6 = $nameObject->upperCamel('_');
    $oName7 = $nameObject->upper('_');

    //--------------------------------------------------------------------------------
    $nameObject = new NamePrototype( SessionManager::daoName() ); // model
    $mName1 = $nameObject->lower();
    $mName2 = $nameObject->lowerCamel();
    $mName3 = $nameObject->upperCamel();
    $mName4 = $nameObject->upper();
    $mName5 = $nameObject->lower('_');
    $mName6 = $nameObject->upperCamel('_');
    $mName7 = $nameObject->upper('_');

    //--------------------------------------------------------------------------------
    $i = 0;
    foreach( getTableColumnsStatus() as $name => $typeObject ) {

        $nameObject = new NamePrototype( $name ); // db table field type name
        $vName1[] = $nameObject->lower();
        $vName2[] = $nameObject->lowerCamel();
        $vName3[] = $nameObject->upperCamel();
        $vName4[] = $nameObject->upper();
        $vName5[] = $nameObject->lower('_');
        $vName6[] = $nameObject->upperCamel('_');
        $vName7[] = $nameObject->upper('_');

        $fieldNumber[$typeObject->name] = $i++;
        $fieldType[]      = $typeObject->type;
        $fieldMaxLength[] = $typeObject->max_length;
    }

    //--------------------------------------------------------------------------------
    // add to templates
    //--------------------------------------------------------------------------------

    $template->assign('status',         getTableColumnsStatus() );
    $template->assign('daoName',        SessionManager::daoName());
    $template->assign('fieldNumber',    $fieldNumber            );
    $template->assign('fieldType',      $fieldType              );
    $template->assign('fieldMaxLength', $fieldMaxLength         );
    $template->assign('oName1',         $oName1                 );
    $template->assign('oName2',         $oName2                 );
    $template->assign('oName3',         $oName3                 );
    $template->assign('oName4',         $oName4                 );
    $template->assign('oName5',         $oName5                 );
    $template->assign('mName1',         $mName1                 );
    $template->assign('mName2',         $mName2                 );
    $template->assign('mName3',         $mName3                 );
    $template->assign('mName4',         $mName4                 );
    $template->assign('mName5',         $mName5                 );
    $template->assign('vName1',         $vName1                 );
    $template->assign('vName2',         $vName2                 );
    $template->assign('vName3',         $vName3                 );
    $template->assign('vName4',         $vName4                 );
    $template->assign('vName5',         $vName5                 );

    return $template;
}
