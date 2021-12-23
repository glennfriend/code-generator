@extends('layouts.admin')

@section('content')

    <form class="well" method="post">

        <div class="row">
            <div class="col-md-4">

{foreach $tab as $key => $field}
{if $key=='id' || substr($key,-2,2)=='Id'}
{elseif $key=='status'}
                <div class="form-group">
                    <label>* {$field.name->upperCamel(' ')}</label>
                    <select class="form-control form-control-sm {ldelim}{ldelim} vvh::FormIsErr('{$field.name->lower("_")}') ? 'is-invalid' : '' {rdelim}{rdelim}"
                            name="{$field.name->lower('_')}">
                        <option value="">-- Select --</option>
                        @foreach(vvh::getStatusArray(${$obj}) as $key => $value)
                            @php
                                $selected = (${$obj}->getStatus() == $key) ? "selected" : "";
                            @endphp
                            <option value="{ldelim}{ldelim} $key {rdelim}{rdelim}" {ldelim}{ldelim} $selected {rdelim}{rdelim}>{ldelim}{ldelim} $value {rdelim}{rdelim}</option>
                        @endforeach
                    </select>
                    @if (vvh::formFieldMsg('{$field.name->lower("_")}'))
                        <small class="form-text invalid-feedback">
                            {ldelim}{ldelim} vvh::formFieldMsg('{$field.name->lower("_")}') {rdelim}{rdelim}
                        </small>
                    @endif
                </div>

{elseif $key=='properties'}
{elseif $field.ado->type=='text' || $field.ado->type=='mediumtext' || $field.ado->type=='longtext'}
                <div class="form-group">
                    <label>{$field.name->upperCamel(' ')}</label>
                    <textarea class="form-control {ldelim}{ldelim} vvh::FormIsErr('{$field.name->lower("_")}') ? 'is-invalid' : '' {rdelim}{rdelim}"
                              name="{$field.name->lower('_')}"
                              >{ldelim}{ldelim} vvh::escape(${$obj}->{$field.name->get()}()) {rdelim}{rdelim}</textarea>
                    @if (vvh::formFieldMsg('{$field.name->lower("_")}'))
                        <small class="form-text invalid-feedback">
                            {ldelim}{ldelim} vvh::formFieldMsg('{$field.name->lower("_")}') {rdelim}{rdelim}
                        </small>
                    @endif
                </div>

{elseif $key=='createAt' || $key=='updateAt' || $key=='deleteAt'}
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
                <div class="form-group">
                    <label>{$field.name->upperCamel(' ')}</label>
                    <input type="text" class="form-control form-control-sm"
                           name="{$field.name->lower("_")}"
                           value="{ldelim}{ldelim} vvh::datetime(${$obj}->{$field.name->get()}()) {rdelim}{rdelim}">
                </div>
                @if (vvh::formFieldMsg('{$field.name->lower("_")}'))
                    <small class="form-text invalid-feedback">
                        {ldelim}{ldelim} vvh::formFieldMsg('{$field.name->lower("_")}') {rdelim}{rdelim}
                    </small>
                @endif

{else}
                <div class="form-group">
                    <label>{$field.name->upperCamel(' ')}</label>
                    <input type="text" class="form-control form-control-sm {ldelim}{ldelim} vvh::FormIsErr('{$field.name->lower("_")}') ? 'is-invalid' : '' {rdelim}{rdelim}"
                           placeholder=""
                           name="{$field.name->lower("_")}"
                           value="{ldelim}{ldelim} vvh::escape(${$obj}->{$field.name->get()}()) {rdelim}{rdelim}">
                    <small class="form-text text-muted">description</small>
                    @if (vvh::formFieldMsg('{$field.name->lower("_")}'))
                        <small class="form-text invalid-feedback">
                            {ldelim}{ldelim} vvh::formFieldMsg('{$field.name->lower("_")}') {rdelim}{rdelim}
                        </small>
                    @endif
                </div>

{/if}
{/foreach}
            </div>
            <div class="col-md-4">

{foreach $tab as $key => $field}
{if $key=='id' || substr($key,-2,2)=='Id'}
                <div class="form-group">
                    <label>{$field.name->upperCamel(' ')}</label>
                    <input type="text" class="form-control form-control-sm" value="{ldelim}{ldelim} ${$obj}->{$field.name->get()}() {rdelim}{rdelim}" readonly>
                </div>

{elseif $key=='createAt' || $key=='updateAt' || $key=='deleteAt'}
                <div class="form-group">
                    <label>{$field.name->upperCamel(' ')}</label>
                    <input type="text" class="form-control form-control-sm" value="{ldelim}{ldelim} vvh::datetime(${$obj}->{$field.name->get()}()) {rdelim}{rdelim}" disabled>
                </div>

{/if}
{/foreach}
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Save</button>

    </form>

@endsection










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
