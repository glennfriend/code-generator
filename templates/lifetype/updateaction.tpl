<?php
    lt_include( PLOG_CLASS_PATH."class/action/admin/adminaction.class.php" );
    lt_include( PLOG_CLASS_PATH."class/view/admin/ajax/adminajaxview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$mName1}.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/plugin{$mName1}listview.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/view/pluginedit{$oName1}view.class.php" );
    class PluginUpdate{$oName3}Action extends AdminAction
    {ldelim}
        function PluginUpdate{$oName3}Action( $actionInfo , $request )
        {ldelim}
            $this->AdminAction( $actionInfo , $request );

            // user permission
            //$this->requireAdminPermission('{$oName5}');  // setAdminOnlyPermission true
            //$this->requirePermission('{$oName5}');       // setAdminOnlyPermission false

            // register && validator
            // registerFieldValidator -> id , validator object , true=予許空值 , 語系
            // IntegerValidator ( true==有號數字 )
            // StringValidator
            // HttpUrlValidator
            // EmailValidator
            // ArrayValidator(new IntegerValidator() )
            // 如果不做 validator , 但是還是希望發生錯的時候資料可以保留而不會消失, 請用 registerField -> $this->registerField('欄位名稱');

{foreach from=$status item=obj}
{section name=i loop=$vName1}
{if $obj->name == $vName5[i]}
            {if $obj->unsigned==1}{assign var=obj_unsigned_string value=''}{else}{assign var=obj_unsigned_string value='true'}{/if}
{if $obj->type     ==     'int'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new IntegerValidator({$obj_unsigned_string}), false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{elseif $obj->type == 'tinyint'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new IntegerValidator({$obj_unsigned_string}), false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{elseif $obj->type == 'varchar'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new StringValidator(),  false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{elseif $obj->type ==    'text'}$this->registerFieldValidator("{$oName2}{$vName3[i]}", {$vName3[i]|space_even} new StringValidator(),  false, $this->_locale->tr("error_{$oName1}_{$vName5[i]}") );
{else}$this->registerField('{$oName2}{$vName3[i]}');  // type is {$obj->type}
{/if}
{/if}
{/section}
{/foreach}

{*
            //data filtering - 登記要把資料做 filter: 在取 $this->_request->getValue() 資料的時候會做 fillter,
            //在這裡登記要做 fillter 的時候, 在做 validator 的時候，資料已經是被 fillter 過了.
            //new HtmlFilter( $filterEntities=false )
            //new TrimFilter()
            //new RegexpFilter( $regexp )  // by preg_replace()

{foreach from=$status item=obj}
    {section name=i loop=$vName1}
        {if $obj->name == $vName5[i]}

            {if     $obj->type == 'varchar'   }$this->_request->registerFilter( "{$oName2}{$vName3[i]}" ,new TrimFilter() );
            {elseif $obj->type == 'text'      }$this->_request->registerFilter( "{$oName2}{$vName3[i]}" ,new HtmlFilter( $filterEntities=false ) );
            {else                             }// {$oName2}{$vName3[i]} type is {$obj->type}
            {/if}

        {/if}
    {/section}
{/foreach}
*}

            $view = new PluginEdit{$oName3}View( $this->_blogInfo );
            $view->setErrorMessage( $this->_locale->tr("error" ));
            $this->setValidationErrorView( $view );

        {rdelim}

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
            $this->_view = new PluginEdit{$oName3}View( $this->_blogInfo );
          //$this->_view = new ErrorView( $this->_blogInfo );  // blog 前台
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

                $this->_view = new PluginEdit{$oName3}View( $this->_blogInfo );
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

            if( !$this->_updateData() ) {ldelim}
                return Array(
                    'successMessage'=>'',
                    'errorMessage'  =>$this->_locale->tr('error_{$oName1}_update')
                );
            {rdelim}

            /*
            if( Request::isXHR()) {ldelim}
                $this->_view = new AdminAjaxView( $this->_blogInfo );  //return table html or ajax json
                $this->_view = new AdminTemplatedView( $this->_blogInfo, "{$oName1}_form" );
                $this->_view = new AdminPluginTemplatedView( $blogInfo , "{$oName1}" , "{$oName1}_form" );
            {rdelim} else {ldelim}
                $this->_view = new PluginEdit{$oName3}View( $this->_blogInfo );
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

            CacheControl::resetBlogCache( $this->_blogInfo->getId() , $resetSummary=false );

            return Array(
                'successMessage'=>$this->_locale->tr('success'),
                'errorMessage'  =>''
            );

        {rdelim}

        /**
         *  @return message array
         */
        function _updateData() {ldelim}


{include file="templates/lifetype/_codegenerator_request.tpl"}


            ${$mName2} = new {$mName3}();
            $my{$oName3} = ${$mName2}->get{$oName3}( $id, $this->_blogInfo->getId() );
            if( !$my{$oName3} ) {ldelim}
                return false;
            {rdelim}

{foreach $vName3 as $key => $val}
{if $val@index!=0}
            $my{$oName3}->set{$vName3.$key}( ${$vName2.$key} );
{/if}
{/foreach}

            $result = ${$mName2}->update{$oName3}( $my{$oName3} );
            if( !$result ) {ldelim}
                return false;
            {rdelim}

            CacheControl::resetBlogCache( $this->_blogInfo->getId() , $resetSummary=false );
            //$this->_view->setValue('{$oName2}', $my{$oName3} );
            return true;

        {rdelim}

    {rdelim}

?>