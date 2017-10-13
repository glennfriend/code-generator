↓
↓這裡必須要修改 ☆★☆★☆★☆★☆★☆
↓
{ldelim}js src="js/ui/pages/{$mName1}.js"{rdelim}
{ldelim}js src="plugins/{$oName1}/js/ui/pages/{$mName1}.js"{rdelim}

<form name="update{$oName3}" id="update{$oName3}" action="admin.php" method="post" onSubmit="Lifetype.UI.Pages.{$mName3}.updateSubmitHook(this);return(false);">

    <fieldset class="inputField">
        <legend>{ldelim}$locale->tr("edit{$oName3}"){rdelim}</legend>
        {ldelim}include file="$admintemplatepath/formvalidateajax.template"{rdelim}

{section name=i loop=$vName1}
{if $smarty.section.i.index==0}{* 
    id 不用顯示 
*}
{elseif $vName2[i]=='properties'}{*
    preperties 不需表單
*}
{elseif $fieldType[i]=='timestamp'}{*
    timestamp 通常不處理 
*}
{elseif $fieldType[i]=='tinyint' && $fieldMaxLength[i]==1}
        <div class="field_checkbox">
            <label for="{$oName2}{$vName3[i]}">{ldelim}$locale->tr("{$oName1}_{$vName5[i]}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <input class="checkbox" type="checkbox" id="{$oName2}{$vName3[i]}" name="{$oName2}{$vName3[i]}" value="1" {ldelim}if ${$oName2}{$vName3[i]}==1 {rdelim} checked="checked" {ldelim}/if{rdelim} />
        </div>

{elseif $fieldType[i]=='text'}
        <div class="field">
            <label for="{$oName2}{$vName3[i]}">{ldelim}$locale->tr("{$oName1}_{$vName5[i]}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <textarea name="{$oName2}{$vName3[i]}" id="{$oName2}{$vName3[i]}" cols="80" rows="12" >{ldelim}${$oName2}{$vName3[i]}{rdelim}</textarea>
            {ldelim}include file="$admintemplatepath/validateajax.template" field={$oName2}{$vName3[i]}{rdelim}
        </div>

{elseif $fieldType[i]=='varchar'}
        <div class="field">
            <label for="{$oName2}{$vName3[i]}">{ldelim}$locale->tr("{$oName1}_{$vName5[i]}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <input type="text" name="{$oName2}{$vName3[i]}" id="{$oName2}{$vName3[i]}" value="{ldelim}${$oName2}{$vName3[i]|escape:'html'}{rdelim}" />
            {ldelim}include file="$admintemplatepath/validateajax.template" field={$oName2}{$vName3[i]}{rdelim}
        </div>

{else}
        <div class="field">
            <label for="{$oName2}{$vName3[i]}">{ldelim}$locale->tr("{$oName1}_{$vName5[i]}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <input type="text" name="{$oName2}{$vName3[i]}" id="{$oName2}{$vName3[i]}" value="{ldelim}${$oName2}{$vName3[i]}{rdelim}" />
            {ldelim}include file="$admintemplatepath/validateajax.template" field={$oName2}{$vName3[i]}{rdelim}
        </div>

{/if}
{/section}

    </fieldset>

    <div class="buttons">
        <input type="hidden" name="{$oName2}Id" value="{ldelim}${$oName2}Id{rdelim}" />
        <input type="hidden" name="op"          value="update{$oName3}" />
        <input type="reset"  name="resetButton" value="{ldelim}$locale->tr("reset"){rdelim}" />
        <input type="submit" name="Update"      value="{ldelim}$locale->tr("update"){rdelim}"/>
    </div>

</form>
