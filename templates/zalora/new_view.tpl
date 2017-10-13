<?php

    $baseUrl = Yii::app()->request->baseUrl;

?>
<link href="<?php  echo $baseUrl; ?>/js/jquery/ui/ui-timepicker/style.css" type="text/css" rel="stylesheet">
<script src="<?php echo $baseUrl; ?>/js/jquery/ui/ui-timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="<?php echo $baseUrl; ?>/js/jquery/ui/ui-timepicker/i18n/ui.datepicker-zh-TW.js"   type="text/javascript"></script>

<section>

    <div class="page-header">
        <h1>New</h1>
    </div>

    <div class="row">
        <div class="span12">

            <form class="form-horizontal well" method="post">
            <fieldset>

{foreach $vName5 as $key => $val}
{if $val=='id'}
{elseif $val=='properties'}
{elseif $val=='status' || $val=='type' ||  $fieldType.$key=='tinyint'}
                <div class="control-group <?php echo FormMessageManager::getFieldStatus('{$vName5.$key}'); ?>">
                    <label class="control-label" for="{$vName5.$key}"><?php echo lgg('dbobject_{$oName5}_{$vName5.$key}'); ?></label>
                    <div class="controls">
                        <select name="{$vName2.$key}">
                            <?php
                                $list = cc('attribList', ${$oName2}, '{$val}');
                                foreach ( $list as $name => $value ) {
                                    $selected = '';
                                    if ( ${$oName2}->get{$vName3.$key}()==$value ) {
                                        $selected = ' selected="selected" ';
                                    }
                                    echo "<option value='{ldelim}$value{rdelim}' {ldelim}$selected{rdelim}>". lgg('dbobject_{$oName5}_'. strtolower($name)) ."</option>";
                                }
                            ?>
                        </select>
                        <?php if ( $message = FormMessageManager::getFieldMessage('{$vName5.$key}') ) {
                            echo '<p class="help-block">'. $message .'</p>';
                        } ?>

                    </div>
                </div>

{elseif $fieldType.$key=='text'}
                <div class="control-group <?php echo FormMessageManager::getFieldStatus('{$vName5.$key}'); ?>">
                    <label class="control-label" for="{$vName5.$key}"><?php echo lgg('dbobject_{$oName5}_{$vName5.$key}'); ?></label>
                    <div class="controls">
                        <textarea class="input-xlarge" name="{$vName2.$key}"><?php echo ${$oName2}->get{$vName3.$key}(); ?></textarea>
                        <?php if ( $message = FormMessageManager::getFieldMessage('{$vName5.$key}') ) {
                            echo '<p class="help-block">'. $message .'</p>';
                        } ?>
                    </div>
                </div>

{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='datetime'}
                <div class="control-group <?php echo FormMessageManager::getFieldStatus('{$vName5.$key}'); ?>">
                    <label class="control-label" for="{$vName5.$key}"><?php echo lgg('dbobject_{$oName5}_{$vName5.$key}'); ?></label>
                    <div class="controls">
                        <input type="text" class="input-xlarge" name="{$vName2.$key}" value="<?php echo cc('date',${$oName2}->get{$vName3.$key}()); ?>" />
                        <?php if ( $message = FormMessageManager::getFieldMessage('{$vName5.$key}') ) {
                            echo '<p class="help-block">'. $message .'</p>';
                        } ?>
                    </div>
                </div>

{elseif $fieldType.$key=='date'}
                <div class="control-group <?php echo FormMessageManager::getFieldStatus('{$vName5.$key}'); ?>">
                    <label class="control-label" for="{$vName5.$key}"><?php echo lgg('dbobject_{$oName5}_{$vName5.$key}'); ?></label>
                    <div class="controls">
                        <input type="text" class="input-xlarge" name="{$vName2.$key}" value="<?php echo cc('date',${$oName2}->get{$vName3.$key}()); ?>" size="10" />
                        <?php if ( $message = FormMessageManager::getFieldMessage('{$vName5.$key}') ) {
                            echo '<p class="help-block">'. $message .'</p>';
                        } ?>
                    </div>
                </div>

{else}
                <div class="control-group <?php echo FormMessageManager::getFieldStatus('{$vName5.$key}'); ?>">
                    <label class="control-label" for="{$vName5.$key}"><?php echo lgg('dbobject_{$oName5}_{$vName5.$key}'); ?></label>
                    <div class="controls">
                        <input type="text" class="input-xlarge" name="{$vName2.$key}" value="<?php echo ${$oName2}->get{$vName3.$key}(); ?>" />
                        <span class="help-inline">*</span>
                        <?php if ( $message = FormMessageManager::getFieldMessage('{$vName5.$key}') ) {
                            echo '<p class="help-block">'. $message .'</p>';
                        } ?>
                    </div>
                </div>

{/if}
{/foreach}

                <div class="form-actions">
                    <input type="hidden" name="parentId" value="<?php echo $parentId; ?>" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>

            </fieldset>
            </form>
        </div>
    </div>

</section>
