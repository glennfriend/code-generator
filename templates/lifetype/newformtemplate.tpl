↓
↓這裡必須要修改 ☆★☆★☆★☆★☆★☆
↓
{ldelim}js src="js/ui/pages/{$mName1}.js"{rdelim}
{ldelim}js src="plugins/{$oName1}/js/ui/pages/{$mName1}.js"{rdelim}

<form name="add{$oName3}" id="add{$oName3}" action="admin.php" method="post" onSubmit="Lifetype.UI.Pages.{$mName3}.addSubmitHook(this);return(false);">

    <fieldset class="inputField">
        <legend>{ldelim}$locale->tr("new{$oName3}"){rdelim}</legend>
        {ldelim}include file="$admintemplatepath/formvalidateajax.template"{rdelim}

{foreach $vName1 as $key => $val}
{if $val@index==0}{*
    id 不用顯示 
*}
{elseif $vName2.$key=='properties'}{*
    preperties 不需表單 
*}
{elseif $fieldType.$key=='timestamp'}{*
    timestamp 通常不處理
*}
{elseif $fieldType.$key=='tinyint' && $fieldMaxLength.$key==1}
        <div class="field_checkbox">
            <label for="{$oName2}{$vName3.$key}">{ldelim}$locale->tr("{$oName1}_{$vName5.$key}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <input class="checkbox" type="checkbox" id="{$oName2}{$vName3.$key}" name="{$oName2}{$vName3.$key}" value="1" {ldelim}if ${$oName2}{$vName3.$key}==1 {rdelim} checked="checked" {ldelim}/if{rdelim} />
        </div>

{elseif $fieldType.$key=='text'}
        <div class="field">
            <label for="{$oName2}{$vName3.$key}">{ldelim}$locale->tr("{$oName1}_{$vName5.$key}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <textarea name="{$oName2}{$vName3.$key}" id="{$oName2}{$vName3.$key}" cols="80" rows="12" >{ldelim}${$oName2}{$vName3.$key}{rdelim}</textarea>
            {ldelim}include file="$admintemplatepath/validateajax.template" field={$oName2}{$vName3.$key}{rdelim}
        </div>

{elseif $fieldType.$key=='varchar'}
        <div class="field">
            <label for="{$oName2}{$vName3.$key}">{ldelim}$locale->tr("{$oName1}_{$vName5.$key}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <input type="text" name="{$oName2}{$vName3.$key}" id="{$oName2}{$vName3.$key}" value="{ldelim}${$oName2}{$vName3.$key}|escape:'html'{rdelim}" />
            {ldelim}include file="$admintemplatepath/validateajax.template" field={$oName2}{$vName3.$key}{rdelim}
        </div>

{else}
        <div class="field">
            <label for="{$oName2}{$vName3.$key}">{ldelim}$locale->tr("{$oName1}_{$vName5.$key}"){rdelim}</label>
            <span class="required">*</span>
            <div class="formHelp"></div>
            <input type="text" name="{$oName2}{$vName3.$key}" id="{$oName2}{$vName3.$key}" value="{ldelim}${$oName2}{$vName3.$key}{rdelim}" />
            {ldelim}include file="$admintemplatepath/validateajax.template" field={$oName2}{$vName3.$key}{rdelim}
        </div>

{/if}
{/foreach}

    </fieldset>

    <div class="buttons">
        <input type="hidden" name="op"          value="add{$oName3}" />
        <input type="reset"  name="resetButton" value="{ldelim}$locale->tr("reset"){rdelim}" />
        <input type="submit" name="Add"         value="{ldelim}$locale->tr("add"){rdelim}"/>
    </div>

</form>

