<?php

    $baseUri = UrlManager::baseUri();
    Yii::app()->clientScript->registerCssFile(    $baseUri . '/js/jquery/ui/ui-timepicker/style.css'                    );
    Yii::app()->clientScript->registerScriptFile( $baseUri . "/js/jquery/ui/ui-timepicker/jquery-ui-timepicker-addon.js");
    Yii::app()->clientScript->registerScriptFile( $baseUri . "/js/jquery/ui/ui-timepicker/i18n/ui.datepicker-zh-TW.js"  );

?>

    <form class="well" method="post">
        <div class="row">
            <div class="col-md-12">

{foreach $tab as $key => $field}
{if $key=='id'}
{elseif $key=='properties'}
{elseif $key=='attribs'}
{elseif $key=='status' || $key=='type' ||  $field.ado->type=='tinyint'}
                <div class="form-group <?php echo FormMessageManager::getFieldStatus('{$field.name->lower("_")}'); ?>">
                    <label for="{$field.name->lower("_")}">
                        * {$field.name->upperCamel(' ')}
                        <br /><?php echo lgg('dbobject_{$obj->lower()}_{$field.name->lower("_")}'); ?>
                    </label>
                    <select class="form-control" name="{$field.name->lower("_")}">
                        <?php
                            $list = cc('attribList', ${$obj}, '{$field.name->lower("_")}');
                            foreach ( $list as $name => $value ) {
                                $selected = '';
                                if ( ${$obj}->{$field.name->get()}()==$value ) {
                                    $selected = ' selected="selected" ';
                                }
                                echo "<option value='{ldelim}$value{rdelim}' {ldelim}$selected{rdelim}>". lgg('dbobject_{$obj->lower()}_'. strtolower($name)) ."</option>";
                            }
                        ?>
                    </select>
                    <?php if ( $message = FormMessageManager::getFieldMessage('{$field.name->lower("_")}') ) {
                        echo '<p class="help-block">'. $message .'</p>';
                    } ?>

                </div>

{elseif $field.ado->type=='text'}
                <div class="form-group <?php echo FormMessageManager::getFieldStatus('{$field.name->lower("_")}'); ?>">
                    <label for="{$field.name->lower("_")}">
                        {$field.name->upperCamel(' ')}
                        <br /><?php echo lgg('dbobject_{$obj->lower()}_{$field.name->lower("_")}'); ?>
                    </label>
                    <textarea class="form-control" name="{$field.name->lower("_")}"><?php echo escape(${$obj}->{$field.name->get()}()); ?></textarea>
                    <?php if ( $message = FormMessageManager::getFieldMessage('{$field.name->lower("_")}') ) {
                        echo '<p class="help-block">'. $message .'</p>';
                    } ?>
                </div>

{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
                <div class="form-group <?php echo FormMessageManager::getFieldStatus('{$field.name->lower("_")}'); ?>">
                    <label for="{$field.name->lower("_")}">
                        * {$field.name->upperCamel(' ')}
                        <br /><?php echo lgg('dbobject_{$obj->lower()}_{$field.name->lower("_")}'); ?>
                    </label>
                    <input type="text" class="form-control" name="{$field.name->lower("_")}" value="<?php echo cc('date',${$obj}->{$field.name->get()}()); ?>" />
                    <?php if ( $message = FormMessageManager::getFieldMessage('{$field.name->lower("_")}') ) {
                        echo '<p class="help-block">'. $message .'</p>';
                    } ?>
                </div>

{else}
                <div class="form-group <?php echo FormMessageManager::getFieldStatus('{$field.name->lower("_")}'); ?>">
                    <label for="{$field.name->lower("_")}">
                        * {$field.name->upperCamel(' ')}
                        <br /><?php echo lgg('dbobject_{$obj->lower()}_{$field.name->lower("_")}'); ?>
                    </label>
                    <input type="text" class="form-control" name="{$field.name->lower("_")}" value="<?php echo escape(${$obj}->{$field.name->get()}()); ?>" />
                    <!-- <span class="help-inline"></span> -->
                    <?php if ( $message = FormMessageManager::getFieldMessage('{$field.name->lower("_")}') ) {
                        echo '<p class="help-block">'. $message .'</p>';
                    } ?>
                </div>

{/if}
{/foreach}

            </div>
        </div>

        <input type="hidden" name="parentId" value="<?php echo $parentId; ?>" />
        <button type="submit" class="btn btn-primary">Save</button>

    </form>
