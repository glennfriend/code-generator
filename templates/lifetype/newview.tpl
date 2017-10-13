<?php
    lt_include( PLOG_CLASS_PATH.'class/view/admin/adminplugintemplatedview.class.php' );
    
    /**
     *  
     */
    class PluginNew{$oName3}View extends AdminPluginTemplatedView 
    {ldelim}
        function PluginNew{$oName3}View( $blogInfo , $params=Array() ) {ldelim}
            /*
                在 add , update , delete 等不會有動作 admin view 的情況下直接使用
                AdminTemplatedView (或定自的AdminPluginTemplatedView) 呼叫其它的 template 即可
            */
            if( Request::isXHR()) {ldelim}
                $template = "new{$oName1}_form";   //show something
            {rdelim} else {ldelim}
                $template = "new{$oName1}";
            {rdelim}
            $this->AdminPluginTemplatedView( $blogInfo , $pluginId='{$oName1}' , $template ); 
        {rdelim}

        function render() {ldelim}
            parent::render();
        {rdelim}

    {rdelim}

?>