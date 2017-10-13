<?php   /* 請使用 utf-8 編碼*/

$messages['{$oName2}Name']             = '__{$oName3}__';
$messages['{$oName2}Config']           = $messages['{$oName2}Name'] .'設定';
$messages['new{$oName3}']              = '新增'. $messages['{$oName2}Name'];
$messages['edit{$oName3}']             = '編輯'. $messages['{$oName2}Name'];
$messages['edit{$mName3}']             = $messages['{$oName2}Name'] .'列表';

$messages['manage{$oName3}Plugins' ]   = $messages['{$oName2}Name'] .'管理 ({$oName3})';
$messages['{$oName2}Plugins']          = $messages['{$oName2}Name'] .'總管理區';
$messages['{$oName1}_plugin']          = $messages['{$oName2}Name'] .'外掛';
$messages['{$oName1}_plugin_enabled']  = '啟動'. $messages['{$oName2}Name'] .'外掛程式';
$messages['{$oName5}_desc']            = $messages['{$oName2}Name'] .'管理 (plugin)';

$messages['{$oName1}_error']           = $messages['edit{$mName3}'] .'發生錯誤';
$messages['error_{$oName1}_add']       = '新增'. $messages['{$oName2}Name'] .'發生錯誤';
$messages['error_{$oName1}_update']    = '更新'. $messages['{$oName2}Name'] .'發生錯誤';
$messages['error_{$oName1}_delete']    = '刪除'. $messages['{$oName2}Name'] .'發生錯誤';
$messages['{$oName1}_delete_ok']       = '成功'. $messages['{$oName2}Name'] .'刪除 (%s)';
$messages['{$oName1}_delete_fail']     = '無法'. $messages['{$oName2}Name'] .'刪除 (%s)';

{foreach from=$status item=obj}
{section name=i loop=$vName1}
{if $obj->name == $vName5[i]}
$messages['{$oName1}_{$vName5[i]}'] {$vName5[i]|space_even} = '{$vName5[i]}';
{/if}
{/section}
{/foreach}

{section name=i loop=$vName1}
$messages['error_{$oName1}_{$vName5[i]}'] {$vName5[i]|space_even} = '『'. $messages['{$oName1}_{$vName5[i]}'] .'』格式不正確';
{/section}


{*
{foreach from=$status item=obj}
    {section name=i loop=$vName1}
        {if $obj->name == $vName5[i]}

            {if $obj->type     == 'int'     }$messages['error_{$oName1}_{$vName5[i]}'] = '{$vName5[i]} 數值錯誤';
            {elseif $obj->type == 'tinyint' }$messages['error_{$oName1}_{$vName5[i]}'] = '{$vName5[i]} 數值錯誤';
            {elseif $obj->type == 'varchar' }$messages['error_{$oName1}_{$vName5[i]}'] = '{$vName5[i]} 錯誤';
            {elseif $obj->type == 'text'    }$messages['error_{$oName1}_{$vName5[i]}'] = '{$vName5[i]} 錯誤';
            {else                           }$messages['error_{$oName1}_{$vName5[i]}'] = '{$vName5[i]} 格式錯誤';
            {/if}

        {/if}
    {/section}
{/foreach}
*}


/*
//$this->_locale->tr('') 
//$this->_locale->pr('',$data) 
foreach( $messages as $keys=>$vals ) {literal}{{/literal}
    $messages[$keys]='<span style=color:#999900>{literal}{{/literal}'.$vals.'{literal}}{/literal}</span>';
{literal}}{/literal}
unset($keys,$vals);
*/
?>