<?php



?>

<link href="<?php  echo Yii::app()->request->baseUrl; ?>/js/jquery/ui-timepicker/style.css" type="text/css" rel="stylesheet">
<script src="<?php echo Yii::app()->request->baseUrl; ?>/js/jquery/ui-timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="<?php echo Yii::app()->request->baseUrl; ?>/js/jquery/ui-timepicker/i18n/ui.datepicker-zh-TW.js"   type="text/javascript"></script>


<?php include $this->getLayoutFile('block_top_messages'); ?>
<form class="form1" method="post" action="<?php echo $requestAction; ?>">

    <fieldset>
        <legend> 新增 </legend>

        <div class="leftBlock">

{foreach $vName5 as $key => $val}
{if $val=='id'}
{elseif $val=='properties'}
{elseif $val=='status' || $val=='type' ||  $fieldType.$key=='tinyint'}
            <div class="field">
                <label for="{$vName2.$key}"> {$vName2.$key} </label>
                <div class="show">
                    <select id="{$vName2.$key}" name="{$vName2.$key}">
                        <?php 
                            foreach( ${$oName2}->getStatusList('{$vName2.$key}') as $name => $id ) {
                                $selected = '';
                                if( ${$oName2}->get{$vName3.$key}()==$id ) {
                                    $selected = ' selected="selected" ';
                                }
                                echo "<option value='{ldelim}$id{rdelim}' {ldelim}$selected{rdelim}>". ${$oName2}->trByName($name) ."</option>";
                            }
                        ?>
                    </select>
                </div>
                <div class="info"></div>
                <?php $errorField="{$vName2.$key}"; include $this->getLayoutFile('block_fields'); ?>
            </div>

{elseif $fieldType.$key=='text'}
            <div class="field">
                <label for="{$vName2.$key}"> {$vName2.$key} </label>
                <div class="show"><textarea id="{$vName2.$key}" name="{$vName2.$key}"><?php echo ${$oName2}->get{$vName3.$key}(); ?></textarea></div>
                <div class="info"></div>
                <?php $errorField="{$vName2.$key}"; include $this->getLayoutFile('block_fields'); ?>
            </div>

{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='datetime'}
            <div class="field">
                <label for="{$vName2.$key}"> {$vName2.$key} </label>
                <div class="show"><input type="text" id="{$vName2.$key}" name="{$vName2.$key}" value="<?php echo ${$oName2}->get{$vName3.$key}ByFormat('Y-m-d H:i:s'); ?>" size="19" /></div>
                <div class="info"></div>
                <?php $errorField="{$vName2.$key}"; include $this->getLayoutFile('block_fields'); ?>
            </div>

{elseif $fieldType.$key=='date'}
            <div class="field">
                <label for="{$vName2.$key}"> {$vName2.$key} </label>
                <div class="show"><input type="text" id="{$vName2.$key}" name="{$vName2.$key}" value="<?php echo ${$oName2}->get{$vName3.$key}ByFormat('Y-m-d'); ?>" size="10" /></div>
                <div class="info"></div>
                <?php $errorField="{$vName2.$key}"; include $this->getLayoutFile('block_fields'); ?>
            </div>

{else}
            <div class="field">
                <label for="{$vName2.$key}"> {$vName2.$key} </label>
                <div class="show"><input type="text" id="{$vName2.$key}" name="{$vName2.$key}" value="<?php echo ${$oName2}->get{$vName3.$key}(); ?>" /></div>
                <div class="info"></div>
                <?php $errorField="{$vName2.$key}"; include $this->getLayoutFile('block_fields'); ?>
            </div>

{/if}
{/foreach}
        </div>
        <div class="rightBlock">
            
            
            
        </div>
        <div class="submitBlock">

            <input class="submit" type="submit" value="新增" />

        </div>
    </fieldset>

</form>

<script type="text/javascript">
    $('#birthday').datetimepicker({
        changeYear: true,
        yearRange: '1900:',
        // showTimepicker: false,
    });
</script>
