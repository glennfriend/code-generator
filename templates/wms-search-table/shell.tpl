<?php

    echo "-- perform ready --\n";

    function perform()
    {
        // {$mod->upperCamel()}
        echo "{$tableName->upperCamel()} start\n";
        Yii::import("{$obj->lowerCamel()}.models.*");
        Yii::import("{$obj->lowerCamel()}.components.*");

        $search = SearchTable::factory('{$tableName->upperCamel()|substr:6}');
        foreach ( $search->generatorRebuildAll() as $id ) {
            showMessage( $id );
        }
        echo "\nend in {ldelim}$id{rdelim}\n";
    }

    function showMessage( $id )
    {
        static $i;
        if ( !$i ) {
            $i=0;
        }

        $i++;
        if ( 1==($i % 20) ) {
            echo $id.' ';
        }
    }
