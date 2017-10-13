<?php
    lt_include( PLOG_CLASS_PATH."class/action/admin/adminaction.class.php" );
    lt_include( PLOG_CLASS_PATH."class/view/admin/ajax/adminajaxview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$mName1}.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/pluginnew{$oName1}view.class.php" );
    class PluginNew{$oName1}Action extends AdminAction
    {ldelim}
        function PluginNew{$oName1}Action( $actionInfo , $request )
        {ldelim}
            $this->AdminAction( $actionInfo , $request );
            // user permission
            //$this->requireAdminPermission('{$oName5}');  // setAdminOnlyPermission true  
            //$this->requirePermission('{$oName5}');       // setAdminOnlyPermission false 
            
        {rdelim}

        function perform() {ldelim}
            return $this->_processData();
        {rdelim}

        function performAjax() {ldelim}
            return $this->_processData();
        {rdelim}

        function _processData()
        {ldelim}
            $this->_view = new PluginNew{$oName3}View( $this->_blogInfo, Array() );
            $this->setCommonData();
            return true;

            /*  blog action 呼叫 view
            $this->_view = new PluginTemplatedView( 
                $this->_blogInfo, 
                $pluginId = "{$oName1}", 
                $template = "{$oName1}", 
                $smartyCache = SMARTY_VIEW_CACHE_CHECK,
                array( 'blogId'=>$blogId ,
                       '其它cache的參數'=>$其它cache的參數 )
            );
            return true;
            */

        {rdelim}

    {rdelim}

?>