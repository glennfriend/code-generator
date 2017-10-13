<?php
    lt_include( PLOG_CLASS_PATH."class/action/admin/adminaction.class.php" );
    lt_include( PLOG_CLASS_PATH."class/view/admin/ajax/adminajaxview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$mName1}.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/plugin{$mName1}listview.class.php" );
    class PluginDelete{$oName3}Action extends AdminAction
    {ldelim}
        var $_mode;

        function PluginDelete{$oName3}Action( $actionInfo , $request ) {ldelim}
            $this->AdminAction( $actionInfo , $request );

            // user permission
            //$this->requireAdminPermission('{$oName5}');  // setAdminOnlyPermission true
            //$this->requirePermission('{$oName5}');       // setAdminOnlyPermission false
    
            $this->_mode = $actionInfo->getActionParamValue();  // get op action name
            if( $this->_mode == "delete{$mName3}" ) {ldelim}
                $this->registerFieldvalidator( "{$oName2}Ids", new ArrayValidator(new IntegerValidator()), false, $this->_locale->tr("error_{$oName1}_id") );
            {rdelim} else {ldelim}
                $this->registerFieldValidator( "{$oName2}Id",  new IntegerValidator(), false, $this->_locale->tr("error_{$oName1}_id")  );
            {rdelim}
            
            $view = new Plugin{$mName3}ListView( $this->_blogInfo );
            $view->setErrorMessage( $this->_locale->tr("error"));
            $this->setValidationErrorView( $view );
            
        {rdelim}

        function perform() {ldelim}

            $message = $this->_processData();
            $this->_view = new Plugin{$mName3}ListView( $this->_blogInfo );
            if( $message["successMessage"] != "" ) {ldelim} 
                $this->_view->setSuccessMessage( $message["successMessage"] ); 
                $isSuccess=true;
            {rdelim}
            if( $message["errorMessage"] != "" ) {ldelim}
                $this->_view->setErrorMessage( $message["errorMessage"] ); 
                $isSuccess=false;
            {rdelim}
            $this->setCommonData();
            return $isSuccess;

        {rdelim}

        function performAjax() {ldelim}

            $message = $this->_processData();
            if( $this->_request->getOutput() == Request::REQUEST_OUTPUT_JSON ) {ldelim}

                $this->_view = new AdminAjaxView( $this->_blogInfo );
              //$this->_view = new AdminErrorDialogView( $this->_blogInfo );
                if( $message["errorMessage"] != "" ) {ldelim}
                    $this->_view->setErrorMessage( $message["errorMessage"] ); 
                    $isSuccess=false;
                {rdelim}
                if( $message["successMessage"] != "" ) {ldelim}
                    $this->_view->setSuccessMessage( $message["successMessage"] ); 
                    $this->_view->setSuccess( true );
                    $isSuccess=true;
                {rdelim}
                
            {rdelim} else {ldelim}  //tableOnly
                die( "output not supported" );
            {rdelim}

            $this->setCommonData();
            return $isSuccess;
        {rdelim}


        function _processData() {ldelim}
            $message = $this->_deleteData();
            CacheControl::resetBlogCache( $this->_blogInfo->getId() , $resetSummary=false );
            return $message;
        {rdelim}

        /**
         *  @return message array
         */
        function _deleteData() {ldelim}

            if( $this->_mode=='delete{$oName3}' ) {ldelim}
                $ids = Array();
                $ids[] = $this->_request->getValue( "{$oName2}Id" );
            {rdelim} else {ldelim}
                $ids = $this->_request->getValue( "{$oName2}Ids" );
            {rdelim}
        
            ${$mName2} = new {$mName3}();
            $successMessage='';
            $errorMessage='';
            foreach( $ids as $id ) {ldelim}

                $my{$oName3} = ${$mName2}->get{$oName3}( $id, $this->_blogInfo->getId() );
                if( !$my{$oName3} ) {ldelim}

                    $errorMessage .= $this->_locale->pr( "error_{$oName1}_delete" , $id ) .'<br />';

                {rdelim} else {ldelim}

                    $result = ${$mName2}->delete{$oName3}( $id );
                    if($result) {ldelim}
                        $successMessage .= $this->_locale->pr( "{$oName1}_delete_ok" , $my{$oName3}->getName() ) .'<br />';
                    {rdelim} else {ldelim}
                        $errorMessage .= $this->_locale->pr( "{$oName1}_delete_fail" , $my{$oName3}->getId() ) .'<br />';
                    {rdelim}

                {rdelim}
            {rdelim}
        
            return Array(
                'successMessage'=>$successMessage,
                'errorMessage'  =>$errorMessage
            );
        
        {rdelim}

    {rdelim}

?>