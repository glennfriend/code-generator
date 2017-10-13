<?php
    lt_include( PLOG_CLASS_PATH."class/action/admin/adminaction.class.php" );
    lt_include( PLOG_CLASS_PATH."class/view/admin/ajax/adminajaxview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$mName1}.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/plugin{$mName1}listview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/pluginnew{$oName1}view.class.php" );

    class PluginAdd{$oName3}Action extends AdminAction
    {ldelim}
        function PluginAdd{$oName3}Action( $actionInfo , $request )
        {ldelim}
            $this->AdminAction( $actionInfo , $request );

            // user permission
            //$this->requireAdminPermission('{$oName5}');  // setAdminOnlyPermission true  
            //$this->requirePermission('{$oName5}');       // setAdminOnlyPermission false 

            // register && validator 
            // registerFieldValidator -> id , validator object , true=予許空值 , 語系
            // $intValidator         = new IntegerValidator(true);  //true==有號數字 , $intValidator->addRule( new IntRangeRule( 1, 99999999 ));
            // $unsignedIntValidator = new IntegerValidator();      //無號數字
            // $strValidator         = new StringValidator();
            // $httpUrlValidator     = new HttpUrlValidator();
            // $emailValidator       = new EmailValidator();
            // ArrayValidator(new IntegerValidator());
            // 如果不做 validator , 但是還是希望發生錯的時候資料可以保留而不會消失, 請用 registerField -> $this->registerField('欄位名稱');

{foreach $status as $obj}
{section name=i loop=$vName1}
{if $obj->name == $vName5[i]}
            {if $obj->unsigned==1}{assign var=obj_unsigned_string value=''}{else}{assign var=obj_unsigned_string value='true'}{/if}
{if $obj->type ==         'int'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new IntegerValidator({$obj_unsigned_string}), false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{elseif $obj->type == 'tinyint'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new IntegerValidator({$obj_unsigned_string}), false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{elseif $obj->type == 'varchar'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new StringValidator(),  false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{elseif $obj->type ==    'text'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new StringValidator(),  false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{else}$this->registerField('{$oName2}{$vName3[i]}');  // type is {$obj->type}
{/if}
{/if}
{/section}
{/foreach}

            $view = new PluginNew{$oName3}View( $this->_blogInfo );
            $view->setErrorMessage( $this->_locale->tr("error" ));
            $this->setValidationErrorView( $view );
        {rdelim}

        /**
         *  建構子設定的 validator 在這裡才真正做 validate
         */
        function validate() {ldelim}

            if( !parent::validate() ) {ldelim}
                return false;
            {rdelim}

            $pluginEnabled = $this->_request->getValue('pluginEnabled');
            $articleId     = $this->_request->getValue('articleId');

            // userInfo need exist 
            if(  !($this->_userInfo && $this->_userInfo->getId()>0)  ) {ldelim}
                return $this->_setErrorView('未登入的使用者無法存取');
            {rdelim}

            // article need exist 
            $articles = new Articles();
            $this->_article = $articles->getArticle( $articleId );
            if( !$this->_article ) {ldelim}
                return $this->_setErrorView();
            {rdelim}

            //validate
            $integerValidate = new IntegerValidator();
            if( !$integerValidate->validate( $articleId )) {ldelim}
                $this->_setValidateError('article_field');
                return $this->_setErrorView();
            {rdelim}

            return true;
        {rdelim}

        function _setErrorView( $messageCode='error' ) {ldelim}
            $this->_view = new PluginNew{$oName3}View( $this->_blogInfo );
          //$this->_view = new ErrorView( $this->_blogInfo ); // blog 前台
            $this->_view->setErrorMessage( $this->_locale->tr($messageCode) );
          //$this->_view->setValue( "message", $this->_locale->tr($messageCode) );
            $this->setCommonData(true);
            return false;
        {rdelim}
        function _setValidateError( $field, $messageCode='error' ) {ldelim}
            $this->_form->setFieldValidationStatus( $field, false );
            $this->_form->setFieldErrorMessage( $field, $this->_locale->tr($messageCode) );            
            $this->validationErrorProcessing();
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
            $this->setCommonData(true);  //true = 當輸入值發生錯誤時, 資料會帶回來
            return $isSuccess;

        {rdelim}

        function performAjax() {ldelim}

            $message = $this->_processData();
            /*
                AdminAjaxView    (傳回一些訊息的時候用此view for ajax)
                                 最後在 control 呼叫 view 的 rander 時
                                 將資料轉為 json , 但是會先去掉一些不必要的資料 => blog,locale,url,config,blogSettings,viewIsError,viewErrorMessage
                                 印出

                AjaxViewRenderer (傳回物件集合的時候用此view for ajax)
                                 最後在 control 呼叫 view 的 rander 時
                                 將資料做一些處理, 而且讓裡面的 object 自己對自己的資料做 toJson 
                                 回傳的一樣是 object 的集合 array
                                 印出
                                 可以對特定物件做寫入
            */
            if( $this->_request->getOutput() == Request::REQUEST_OUTPUT_JSON ) {ldelim}
                
                die( "output not supported" );

                $this->_view = new AdminAjaxView( $this->_blogInfo );
                if( $message["errorMessage"] != "" ) {ldelim}
                  //$this->_view = new AdminErrorDialogView( $this->_blogInfo );
                    $this->_view->setErrorMessage( $message["errorMessage"] ); 
                    $isSuccess=false;
                {rdelim}
                if( $message["successMessage"] != "" ) {ldelim}
                    $this->_view->setSuccessMessage( $message["successMessage"] ); 
                    $this->_view->setSuccess( true );
                    $isSuccess=true;
                {rdelim}
                
                /*
                if( $isSuccess ) {ldelim}
                    $this->_view->setResult( 物件 );
                    $this->_view->setResult( true );
                    $this->_view->setResult( $this->_blogInfo );
                    $this->_view->setResult( Array( 'userInfo'=>$this->_userInfo , 'blogInfo' => $this->_blogInfo ) );
                {ldelim}

                //--------------------------------------------------------------------------------
                $this->_view = new AjaxViewRenderer( $view );
                $this->_view->setSuccess( $isSuccess );
                $this->_view->setMessage( $message );
                $this->_view->setResultObject( '物件名稱' );
                $this->_view->setResult( dao_dbobject物件 ); //??
                */
            {rdelim} else {ldelim}  //tableOnly

                die( "output not supported" );

                $this->_view = new PluginNew{$oName3}View( $this->_blogInfo );
                if( $message["errorMessage"] != "" ) {ldelim}
                    $this->_view->setErrorMessage( $message["errorMessage"] ); 
                    $isSuccess=false;
                {rdelim}
                if( $message["successMessage"] != "" ) {ldelim}
                    $this->_view->setSuccessMessage( $message["successMessage"] ); 
                    $this->_view->setSuccess( true );
                    $isSuccess=true;
                {rdelim}

            {rdelim}

            $this->setCommonData(true);  //true = 當輸入值發生錯誤時, 資料會帶回來
            return $isSuccess;
        {rdelim}


        function _processData() {ldelim}

            //$blogId = $this->_blogInfo->getId();
            //$userId = $this->_userInfo->getId();
            //$config = Config::getConfig();
            //$config->getValue('______');

            if( !$this->_addData() ) {ldelim}
                return Array(
                    'successMessage'=>'',
                    'errorMessage'  =>$this->_locale->tr('error_{$oName1}_add')
                );
            {rdelim}

            /*
            if( Request::isXHR()) {ldelim}
                $this->_view = new AdminAjaxView( $this->_blogInfo );  //return table html or ajax json
                $this->_view = new AdminTemplatedView( $this->_blogInfo, "{$oName1}_form" );
                $this->_view = new AdminPluginTemplatedView( $blogInfo , "{$oName1}" , "{$oName1}_form" );
            {rdelim} else {ldelim}
                $this->_view = new PluginNew{$oName3}View( $this->_blogInfo );
                $this->_view = new AdminTemplatedView( $this->_blogInfo, "{$oName1}" );
                $this->_view = new AdminPluginTemplatedView( $blogInfo , "{$oName1}" , "{$oName1}" );
            {rdelim}
            */

            /*
            //前台 action 呼叫 view
            $this->_view = new PluginTemplatedView( 
                $this->_blogInfo, 
                $pluginId = "{$oName1}", 
                $template = "{$oName1}", 
                $smartyCache = SMARTY_VIEW_CACHE_CHECK,
                array( 'blogId'=> $this->_blogInfo->getId() ,
                       '其它參數'=>$其它參數 )
            );
            */

            //當後台的設定會影響前台時，就必須清掉前台相關的 cache
            //如果這個設定只影響一個 blog 的使用者 ; 就只要清除一個 blog 的 cache 就可以了
            //CacheControl::resetAllCaches();
            //CacheControl::resetSummaryCache();
            CacheControl::resetBlogCache( $this->_blogInfo->getId() , $resetSummary=false );

            return Array(
                'successMessage'=>$this->_locale->tr('success'),
                'errorMessage'  =>''
            );

        {rdelim}

        /**
         *  @return insert id (integer) or false
         */
        function _addData() {ldelim}

{include file="templates/lifetype/_codegenerator_request.tpl"}

            ${$mName2} = new {$mName3}();
            ↓
            ↓這裡必須要修改 ☆★☆★☆★☆★☆★☆
            ↓
            ${$oName2} = new {$oName3}( 初始值或變數, 初始值或變數, ...., Timestamp::getNowTimestamp() );
            $resultId = ${$mName2}->add{$oName3}( ${$oName2} );
            if( !$resultId ) {ldelim}
                return false;
            {rdelim}
            return $resultId;

        {rdelim}

    {rdelim}

?>