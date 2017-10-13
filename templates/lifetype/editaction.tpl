<?php
    lt_include( PLOG_CLASS_PATH."class/action/admin/adminaction.class.php" );
    lt_include( PLOG_CLASS_PATH."class/view/admin/ajax/adminajaxview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$mName1}.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/plugin{$mName1}listview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/pluginedit{$oName1}view.class.php" );
    class PluginEdit{$oName3}Action extends AdminAction 
    {ldelim}
        function PluginEdit{$oName3}Action( $actionInfo , $request )
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

        function _processData() {ldelim}

            ${$oName2}Id = $this->_request->getValue("{$oName2}Id");
            ${$mName2} = new {$mName3}();
            ${$oName2} = ${$mName2}->get{$oName3}( ${$oName2}Id, $this->_blogInfo->getId() );
            if(!${$oName2}) {ldelim}

                /*
                    //未測試
                    if( Request::isXHR() ) {
                        $this->_view = new AdminErrorDialogView( $this->_blogInfo );
                    }
                    else {
                        //$this->_view = new AdminErrorView(  $this->_blogInfo );
                        $this->_view = new Plugin{$mName3}ListView( $this->_blogInfo );
                    }
                */
                $this->_view = new Plugin{$mName3}ListView( $this->_blogInfo );

                $this->_view->setErrorMessage( $this->_locale->tr("error") );
                $this->setCommonData();
                return false;
            {rdelim}

            $this->_view = new PluginEdit{$oName3}View( $this->_blogInfo );
            $this->setCommonData();  // param==true is 當 admin 輸入值發生錯誤時, 資料會帶回來, 不會遺失
            return true;

            /*
            //blog action 呼叫 view
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