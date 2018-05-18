<?php // 請儲存 UTF-8 格式

    // {$obj}
{foreach $tab as $key => $field}
{if $key=='status' || $key=='type' || $field.ado->type=='tinyint'}
    // ---- {$obj} {$key} ------------------------------------------------------------
        'dbobject_{$obj->lower()}_{$field.name->lower("_")}'{$field.name->lower("_")|space_even:32}        => '狀態',
        'dbobject_{$obj->lower()}_{$field.name->lower("_")}_all'{$field.name->lower("_")|space_even:32}    => '所有',
        'dbobject_{$obj->lower()}_{$field.name->lower("_")}_open'{$field.name->lower("_")|space_even:32}   => '啟用',
        'dbobject_{$obj->lower()}_{$field.name->lower("_")}_close'{$field.name->lower("_")|space_even:32}  => '關閉',
        'dbobject_{$obj->lower()}_{$field.name->lower("_")}_delete'{$field.name->lower("_")|space_even:32} => '刪除',
    // ==== {$obj} {$key} ============================================================
{elseif in_array( $key, array('id','createdAt','updatedAt','properties') ) }
{else}
    'dbobject_{$obj->lower()}_{$field.name->lower("_")}'{$field.name->lower("_")|space_even:39} => '{$field.name->lower(' ')|ucwords}',
{/if}
{/foreach}

/*
    物件語系命名:

        全小寫
        dbobject _ 無符號的物件名稱 _ 使用下底線的變數名稱

    其它語系命名:

*/
