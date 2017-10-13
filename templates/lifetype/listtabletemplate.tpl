↓
↓這裡必須要修改 ☆★☆★☆★☆★☆★☆
↓
{ldelim}js src="js/ui/pages/{$mName1}.js"{rdelim}
{ldelim}js src="plugins/{$oName1}/js/ui/pages/{$mName1}.js"{rdelim}

<table class="info" summary="{ldelim}$locale->tr('edit{$mName3}'){rdelim}">
    <thead>
        <tr>
            <th style="width:10%;"><input class="checkbox" type="checkbox" name="all" id="all" value="1" onclick="Lifetype.Forms.toggleAllChecks('list{$mName3}');" /></th>
            <th style="width:10%;">[name]</th>
{section name=i loop=$vName1}
{if $vName1[i]=='properties'}
            {* 不須顯示 *}
{else}
            <th style="width:10%;">{ldelim}$locale->tr("{$vName5[i]}"){rdelim}</th>
{/if}
{/section}
            <th style="width:10%;">{ldelim}$locale->tr("actions"){rdelim}</th>
        </tr>
    </thead>
    <tbody>

        {ldelim}foreach from=${$mName2} item={$oName2}{rdelim}
            <tr class="even">
                <td>
                    <input class="checkbox" type="checkbox" name="{$oName2}Ids[{ldelim}counter{rdelim}]" id="checks_{ldelim}${$oName2}->getId(){rdelim}" value="{ldelim}${$oName2}->getId(){rdelim}" />
                </td>
                <td class="col_highlighted">
                    {ldelim}check_perms perm=update_{$oName2}{rdelim}<a id="item_name_{ldelim}${$oName2}->getId(){rdelim}" rel="overlay" href="admin.php?op=edit{$oName3}&amp;{$oName2}Id={ldelim}${$oName2}->getId(){rdelim}">{ldelim}/check_perms{rdelim}
                    [name-value]
                    {ldelim}check_perms perm=update_{$oName2}{rdelim}</a>{ldelim}/check_perms{rdelim}
                </td>

{section name=i loop=$vName1}
{if $vName1[i]=='properties'}
    {* 不須顯示 *}
{elseif $fieldType[i]=='timestamp'}
                <td>{ldelim}$locale->formatDate(${$oName2}->get{$vName3[i]}(),"%Y-%m-%d %H:%M"){rdelim}</td>
{elseif $fieldType[i]=='varchar'}
                <td>{ldelim}${$oName2}->get{$vName3[i]}()|strip_tags|utf8_truncate:20{rdelim}</td>
{elseif $fieldType[i]=='text'}
                <td>{ldelim}${$oName2}->get{$vName3[i]}()|strip_tags|utf8_truncate:40{rdelim}</td>
{else}
                <td>{ldelim}${$oName2}->get{$vName3[i]}(){rdelim}</td>
{/if}
{/section}

                <td>
                    <div class="list_action_button">
                        {ldelim}check_perms perm=update_{$oName2}{rdelim}
                            <a rel="overlay" id="edit_link_{ldelim}${$oName2}->getId(){rdelim}" href="?op=edit{$oName3}&amp;{$oName2}Id={ldelim}${$oName2}->getId(){rdelim}" title="{ldelim}$locale->tr('edit'){rdelim}" >
                                <img src="imgs/admin/icon_edit-16.png" alt="{ldelim}$locale->tr('edit'){rdelim}" />
                            </a>
                            <a href="?op=delete{$oName3}&amp;{$oName2}Id={ldelim}${$oName2}->getId(){rdelim}" title="{ldelim}$locale->tr('delete'){rdelim}" onClick="Lifetype.Forms.performRequest(this);return(false);">
                                <img src="imgs/admin/icon_delete-16.png" alt="{ldelim}$locale->tr('delete'){rdelim}" />
                            </a>
                        {ldelim}/check_perms{rdelim}
                    </div>
                </td>

            </tr>
        {ldelim}/foreach{rdelim}

    </tbody>
</table>
{ldelim}adminpagerajax style=list{rdelim}




