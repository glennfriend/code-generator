
    //------------------------------------------------------------------------------------------------------------------------
    // pluginedit{$mName1}action.class.php
    //------------------------------------------------------------------------------------------------------------------------

<?php
    lt_include( PLOG_CLASS_PATH."class/action/admin/adminaction.class.php" );
    lt_include( PLOG_CLASS_PATH."class/view/admin/ajax/adminajaxview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$mName1}.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/plugin{$mName1}listview.class.php" );
    class PluginEdit{$mName3}Action extends AdminAction 
    {ldelim}
        function PluginEdit{$mName3}Action( $actionInfo , $request )
        {ldelim}
            $this->AdminAction( $actionInfo , $request );
            //$this->BlogAction( $actionInfo , $request );  // 上方請配合使用 BlogAction

            // user permission
            //$this->requireAdminPermission('{$oName5}');  // setAdminOnlyPermission true  
            //$this->requirePermission('{$oName5}');       // setAdminOnlyPermission false 
    
            //$actionInfo->getActionParamName();   // op name
            //$actionInfo->getActionParamValue();  // action name
    
            /* 
                下方 new view 的部份:
                (1) 如果 action 必須傳某些值給 view , 可以放在 view 參數 後方,經由後面的參數傳送
                (2) 如果有錯 (validate) 就交給 view  去顯示, 並不用在這個地方考慮是 html 或 ajax (就是指Request::isXHR()), 因為顯示方式是由 view 決定,
                    您只要記得在 下方的 view 中記得去處理 html/ajax 的狀況就好了

                // admin
                // --------------------------------------------------------------------------------
                $view = new Plugin{$mName3}ListView( $this->_blogInfo );
                $view->setErrorMessage( $this->_locale->tr("{$oName1}_error") );
                $this->setValidationErrorView( $view );

                // blog
                // --------------------------------------------------------------------------------
                $view = new ErrorView( $this->_blogInfo, "error" );
                $this->setValidationErrorView( $view );
            */
            
        {rdelim}

        function perform() {ldelim}
            return $this->_processData();
        {rdelim}

        function performAjax() {ldelim}
            return $this->_processData();
        {rdelim}

        function _processData() {ldelim}

            $this->_view = new Plugin{$mName3}ListView( $this->_blogInfo );
            $this->setCommonData();
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