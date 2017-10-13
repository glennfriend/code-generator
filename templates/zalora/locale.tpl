<?php
/*
    請儲存 UTF-8 格式
    注意必須使用全小寫
*/


    // {$oName2}
{foreach $vName5 as $key => $val}
{if $val=='status' || $val=='type' || $fieldType.$key=='tinyint'}
    // {$val} - start
    'dbobject_{$oName1}_{$vName5.$key}'        {$oName1|space_even}{$vName5.$key|space_even} => '狀態',
    'dbobject_{$oName1}_{$vName5.$key}_all'    {$oName1|space_even}{$vName5.$key|space_even} => '所有',
    'dbobject_{$oName1}_{$vName5.$key}_open'   {$oName1|space_even}{$vName5.$key|space_even} => '啟用',
    'dbobject_{$oName1}_{$vName5.$key}_close'  {$oName1|space_even}{$vName5.$key|space_even} => '關閉',
    'dbobject_{$oName1}_{$vName5.$key}_delete' {$oName1|space_even}{$vName5.$key|space_even} => '刪除',
    // {$val} - end
{else}
    'dbobject_{$oName1}_{$vName5.$key}'        {$oName5|space_even}{$vName5.$key|space_even} => '{$vName3.$key}',
{/if}
{/foreach}

