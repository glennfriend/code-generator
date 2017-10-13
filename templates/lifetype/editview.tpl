<?php
    lt_include( PLOG_CLASS_PATH.'class/view/admin/adminplugintemplatedview.class.php' );
    
    /**
     *  
     */
    class PluginEdit{$oName3}View extends AdminPluginTemplatedView 
    {ldelim}
        function PluginEdit{$oName3}View( $blogInfo , $params=Array() )
        {ldelim}
            /*
                在 add , update , delete 等不會有動作 admin view 的情況下直接使用
                AdminTemplatedView (或定自的AdminPluginTemplatedView) 呼叫其它的 template 即可
            */
            if( Request::isXHR()) {ldelim}
                $template = "edit{$oName1}_form";   //只傳回某些部份 的 表單
            {rdelim} else {ldelim}
                $template = "edit{$oName1}";
            {rdelim}
            $this->AdminPluginTemplatedView( $blogInfo , $pluginId='{$oName1}' , $template ); 
        {rdelim}

        function render()
        {ldelim}
            ${$oName2}Id = (int) $this->_request->getValue( "{$oName2}Id" );
            ${$mName2} = new {$mName3}();
            ${$oName2} = ${$mName2}->get{$oName3}( ${$oName2}Id, $this->_blogInfo->getId() );

            $this->setValue( "{$oName2}Id", ${$oName2}Id );
            //$this->setValue( "{$oName2}",   ${$oName2} );

{foreach $vName1 as $key => $val}
{if $val@index==0}
{elseif $val@index!=($val@total)}
            $this->setValue( "{$oName2}{$vName3.$key}", {$vName3.$key|space_even} ${$oName2}->get{$vName3.$key}() );
{else}
{/if}
{/foreach}

            parent::render();
        {rdelim}

    {rdelim}

?>