{ldelim}include file="$admintemplatepath/header.template"{rdelim}
{ldelim}include file="$admintemplatepath/navigation.template" showOpt=edit{$mName3} title=$locale->tr("{$oName2}Plugins"){rdelim}

↓
↓這裡必須要修改 ☆★☆★☆★☆★☆★☆
↓
{ldelim}js src="js/ui/pages/{$mName1}.js"{rdelim}
{ldelim}js src="plugins/{$oName1}/js/ui/pages/{$mName1}.js"{rdelim}

<div id="list_nav_bar">
    <div id="list_nav_select">
        <form id="view{$mName3}" action="admin.php" method="post">
            <fieldset>
                <legend>{ldelim}$locale->tr("show_by"){rdelim}</legend>

                <div class="list_nav_option">
                    <label for="search">{ldelim}$locale->tr("search_terms"){rdelim}</label>
                    <br />
                    <input type="text" name="searchTerms" value="{ldelim}$searchTerms{rdelim}" size="15" id="search" />
                </div>   

                <div class="list_nav_option">
                    <br />
                    <input type="hidden" name="op" value="edit{$mName3}" />
                    <input type="submit"           value="{ldelim}$locale->tr("show"){rdelim}" />
                </div>
            </fieldset> 
        </form> 
    </div>
    <br style="clear:both" />
</div> 

<div class="extraFunctions">
    <div class="left">
        <a id="new{$oName3}Button" href="?op=new{$oName3}" rel="overlay">{ldelim}$locale->tr("new{$oName3}"){rdelim}</a>
    </div>
    <br style="clear:both" />
</div>

<form id="list{$mName3}" action="admin.php" method="post" onSubmit="Lifetype.Forms.performRequest(this);return(false);">
    {ldelim}include file="$admintemplatepath/viewvalidateajax.template"{rdelim}
    <div id="list">
        {ldelim}include file="edit{$mName1}_table.template"{rdelim}
    </div>
    <div id="list_action_bar">
        {ldelim}check_perms perm={$oName5}{rdelim}
            <input type="hidden" name="op" value="delete{$mName3}"/>
            <input type="submit" name="Delete selected" value="{ldelim}$locale->tr("delete"){rdelim}"/>
        {ldelim}/check_perms{rdelim}
    </div>
</form>

{ldelim}include file="$admintemplatepath/footernavigation.template"{rdelim}
{ldelim}include file="$admintemplatepath/footer.template"{rdelim}
