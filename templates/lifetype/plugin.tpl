<?php

    //
    // controller/______controllermap.properties.php  -  撰寫非 plug-in 時使用
    //
    $actions["{$oName2}"]              =        "Admin{$oName3}Action"       ;
    $actions["{$oName2}Config"]        =        "Admin{$oName3}ConfigAction" ;
    $actions["update{$oName3}Config"]  =  "AdminUpdate{$oName3}ConfigAction" ;
    $actions["edit{$mName3}"]         =    "AdminEdit{$mName3}Action"      ; //list show page
    $actions["edit{$oName3}"]          =    "AdminEdit{$oName3}Action"       ; //edit show page
    $actions["new{$oName3}"]           =     "AdminNew{$oName3}Action"       ; //new  show page
    $actions["add{$oName3}"]           =     "AdminAdd{$oName3}Action"       ; //add
    $actions["update{$oName3}"]        =  "AdminUpdate{$oName3}Action"       ; //update
    $actions["delete{$oName3}"]        =  "AdminDelete{$oName3}Action"       ; //delete
    $actions["delete{$mName3}"]       =  "AdminDelete{$oName3}Action"       ; //delete many

    //
    // class/classloadermap.properties.php  -  撰寫非 plug-in 時使用
    //
    // {$mName3} - action
          "admin{$oName1}action"          => "class/action/admin/admin{$oName1}action.class.php",
      "adminedit{$oName1}configaction"    => "class/action/admin/adminedit{$oName1}configaction.class.php",
    "adminupdate{$oName1}configaction"    => "class/action/admin/adminupdate{$oName1}configaction.class.php",
      "adminedit{$mName1}action"         => "class/action/admin/adminedit{$mName1}action.class.php",
      "adminedit{$oName1}action"          => "class/action/admin/adminedit{$oName1}action.class.php",
       "adminnew{$oName1}action"          => "class/action/admin/adminnew{$oName1}action.class.php",
       "adminadd{$oName1}action"          => "class/action/admin/adminadd{$oName1}action.class.php",
    "adminupdate{$oName1}action"          => "class/action/admin/adminupdate{$oName1}action.class.php",
    "admindelete{$oName1}action"          => "class/action/admin/admindelete{$oName1}action.class.php",
    // view
          "admin{$oName1}view"            => "class/view/admin/admin{$oName1}view.class.php",
      "adminedit{$oName1}configview"      => "class/view/admin/adminedit{$oName1}configview.class.php",
      "admin{$mName1}listview"           => "class/view/admin/admin{$mName1}listview.class.php",
      "adminedit{$oName1}view"            => "class/view/admin/adminedit{$oName1}view.class.php",
       "adminnew{$oName1}view"            => "class/view/admin/adminnew{$oName1}view.class.php",
    // dao
    "{$oName1}"                           => "class/dao/{$oName1}.class.php",
    "{$mName1}"                          => "class/dao/{$mName1}.class.php",




    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/helper/plugin{$oName1}utils.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$mName1}.class.php" );

    define('PLUGIN_{$oName4}_??????', '10' );
    define('PLUGIN_{$oName4}_??????', '20' );

    /**
     *  plug name - plugin{$oName1}.class.php
     */    
    class Plugin{$oName3} extends PluginBase
    {
        function Plugin{$oName3}( $source='' )
        {
            $this->PluginBase( $source );
            $this->id       = '{$oName1}';
            $this->version  = '{$smarty.now|date_format:"%Y%m"}';
            $this->author   = 'glenn';
            $this->desc     = 'the plugin descendant';
            $this->locales  = Array();
            
            if( $source == "admin" ) {
                $this->initAdmin();
            }
            else {
                $this->init();
            }
        }

        function initAdmin() 
        {
            //register admin actions control 
          //$this->registerAdminAction(       "{$oName2}",             "Plugin{$oName3}Action"       ); 
          //$this->registerAdminAction(       "{$oName2}Config",       "Plugin{$oName3}ConfigAction" ); 
          //$this->registerAdminAction( "update{$oName3}Config", "PluginUpdate{$oName3}ConfigAction" ); 
            $this->registerAdminAction(   "edit{$mName3}",        "PluginEdit{$mName3}Action"      ); //list show page
            $this->registerAdminAction(   "edit{$oName3}",         "PluginEdit{$oName3}Action"       ); //edit show page
            $this->registerAdminAction(    "new{$oName3}",          "PluginNew{$oName3}Action"       ); //new  show page
            $this->registerAdminAction(    "add{$oName3}",          "PluginAdd{$oName3}Action"       ); //add
            $this->registerAdminAction( "update{$oName3}",       "PluginUpdate{$oName3}Action"       ); //update
            $this->registerAdminAction( "delete{$oName3}",       "PluginDelete{$oName3}Action"       ); //delete
            $this->registerAdminAction( "delete{$mName3}",      "PluginDelete{$oName3}Action"       ); //delete many

            // register our permissions, add our new permission if it doesn't exist yet
            lt_include( PLOG_CLASS_PATH."class/dao/permissions.class.php" );
            $perms = new Permissions();
            if( !$perms->getPermissionByName( "{$oName5}" )) {
                $perm = new Permission( "{$oName5}", "{$oName5}_desc" );
                $perm->setAdminOnlyPermission( false ); // false => $this->requirePermission('{$oName5}');
                                                        // true  => $this->requireAdminPermission('{$oName5}');
                $perm->isCorePermission( false );
                $perms->addPermission( $perm );
            }

        }

        function init() 
        {
            //Register index (blog) actions control
            $this->registerBlogAction(   "edit{$mName3}",    "PluginEdit{$mName3}Action"  ); //list show page
            $this->registerBlogAction(   "edit{$oName3}",     "PluginEdit{$oName3}Action"   ); //edit show page
            $this->registerBlogAction(    "new{$oName3}",      "PluginNew{$oName3}Action"   ); //new  show page
            $this->registerBlogAction(    "add{$oName3}",      "PluginAdd{$oName3}Action"   ); //add
            $this->registerBlogAction( "delete{$oName3}",   "PluginDelete{$oName3}Action"   ); //delete
            $this->registerBlogAction( "update{$oName3}",   "PluginUpdate{$oName3}Action"   ); //update

            //eventlist.properties.php , 在 init前台 或 initAdmin後台 都是用一樣的名稱 registerNotification() 
            //$this->registerNotification( EVENT_POST_LOADED        );
            //$this->registerNotification( EVENT_POSTS_LOADED       );
            //$this->registerNotification( EVENT_COMMENTS_LOADED    );

            //lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/security/{$oName1}filter.class.php" );
            //$this->registerFilter( "{$oName3}Filter" );
        }

        /**
         * 外掛 在 外掛管理系統 之中會全部 new 一個實體之後，再一次執行所有的 register()
         * 所以如果在外掛程式自己呼叫的 action , view 要呼叫自己的時候，必須自己執行
         * 
         *   $thePluginObj->setBlogInfo( $this->_blogInfo );
         *   $thePluginObj->setUserInfo( $this->_userInfo );
         *   $thePluginObj->register();
         * 
         * 等資訊..
         * 如果要知道管理外掛程式原本執行的那些動作, 可以查看
         * class/plugin/pluginmanager.class.php
         * 的 getPlugins() 本身到底做了什麼
         */
        function register()
        {

            /*
                確認您要將項目放於那一個 menu list 中

                2.0 版本

                /menu/Content/managePosts
                Manage
                ResourcesGroup
                controlCenter
                adminSettings
                resources
                
                ilcBlog 版本
                
                /menu/Content           文章內容
                /menu/resources         檔案
                /menu/friendManagement  好友管理
                /menu/controlCenter     個人網誌設定
                /menu/adminSettings     全部站台管控
                /menu/adminSettings/siteContent     
                /menu/adminSettings/GlobalSettings  全域設定
                /menu/adminSettings/Plugins         外掛設定
                /menu/adminSettings/Miscellaneous   其它設定

            */
            $menu = & Menu::getMenu();
            //add class-item in  templates/admin/menus.xml 
            //(以下這些是動態寫入,每次執行寫一遍)
            if( !$menu->entryExists("/menu/manage{$oName3}Plugins") ) {
                //create directory  =>  path , id/showOpt , url , localeId , orPerms Array , andPerms Array, siteAdmin, entryOrder, cacheEnabled(false=清除 menu cache)
              //$this->addMenuEntry("/menu", "manage{$oName3}Plugins", null, "", true, false ); 
                $this->addMenuEntry("/menu", "manage{$oName3}Plugins", null, Array(''), Array('{$oName5}'), $siteAdmin=false, -1, false   ); 
                //create item
                $this->addMenuEntry("/menu/manage{$oName3}Plugins", "edit{$mName3}", "?op=edit{$mName3}", null, Array(''), Array('{$oName5}'), false, -1, false  ); // list edit update controll  
                $this->addMenuEntry("/menu/manage{$oName3}Plugins", "new{$oName3}",  "?op=new{$oName3}",  null, Array(''), Array('{$oName5}'), false, -1, false  ); // new  add         controll
            }

            //如果是全域的部份請寫到這裡
            if( !$menu->entryExists("/menu/adminSettings/GlobalSettings/{$oName2}") ) {
                $this->addMenuEntry( $path = "/menu/adminSettings/GlobalSettings",
                                     $id   = "{$oName2}",
                                     $url  = "?op={$oName2}",
                                     $localeId = null 
                );
            }

        }

        /** 
         * lifetype global variable config 
         */
        function getPluginConfigurationKeys()
        {
            return (Array(
                Array(      "name"      => "plugin_{$oName1}_enabled",
                            "type"      => "boolean"
                ), Array(   "name"      => "plugin_{$oName1}_變數",
                            "validator" => new IntegerValidator(),
                            "type"      => "integer", 
                            "allowEmpty"=> true 
                ), Array(   "name"      => "plugin_{$oName1}_變數",
                            "validator" => new StringValidator(),
                            "type"      => "string", 
                            "allowEmpty"=> true 
                ),
            ));
        }

        /**
         *  EVENT process
         *  語系的部份，前台用 $this->blogInfo->_blogLocale->tr('')
         *              後台用 $this->blogInfo->_locale->tr('')
         *
         *  @return boolean 
         */
        /*
        function process( $eventType, $params ) 
        {

            // 權宜之計
            //if( empty($this->_userInfo ) ) {
            //    $this->_userInfo = $this->_getUserInfo();
            //}
            
            $request = $params["request"];

            switch( $eventType ) {
                case EVENT_POST_LOADED:
                    if( !isset( $params["article"] )) {
                        return false;
                    }
                    
                    //如果要處理值之後, 再寫到 view , 可以這樣寫
                    //$params["article"]->_myPlugin_tags = 123;
                    //到時候 view 的叫用方法如下
                    //
                    
                break;
                case EVENT_POSTS_LOADED:
                    if( !isset( $params["articles"] )) {
                        return false;
                    }
                break;
                case EVENT_COMMENTS_LOADED:
                    if( !isset( $params["comments"] )) {
                        return false
                    }
                break;
                case EVENT_POST_COMMENT_ADD:
                    $userId = $params['comment']->_userId;
                    if($userId<=0) {
                        return false;  //沒註冊的 comment 就不處理
                    }
                    
                break;
                case EVENT_POST_POST_UPDATE:
                    //這裡可能會有刪除的動作, 而刪除的動作並不會觸發 "EVENT_POST_POST_DELETE"
                    
                break;
                case EVENT_POST_POST_DELETE:
                    // 假刪時的動作 
                    if( !isset( $params["article"] )) {
                        return false;
                    }
                    $userId    = $params['article']->getUserId();
                    $articleId = $params['article']->_id;
                    if(!$articleId or $articleId<=0) {
                        return false;
                    }
                break;
                case EVENT_POST_COMMENT_DELETE:
                    // 刪除 Article 的時候，並不會連下面的 comment 一起刪除 
                    $userId    = $params['comment']->_userId;
                    if($userId==0) {
                        return false;  //沒註冊的 comment 就不處理
                    } 
                break;
                default:
                    return false;
                break;
            }
            return true;
        }
        */

        //------------------------------------------------------------------------------------------------------------------------
        /**
         *  set plugin settings
         */
        public function setPluginSettings( $blog, $request )
        {
            $config = $blog->getSettings();
            $config->setValue('plugin_{$oName1}_enabled', (int) $request->getValue('plugin{$oName3}Enabled') );
            $blog->setSettings( $config );
            $blogs = new Blogs();
            $blogs->updateBlog($blog);
        }

        /**
         *  get plugin settings
         */
        public function getPluginSettings( $blog )
        {
            $settings = $blog->getSettings();
            return Array(
                'plugin{$oName3}Enabled' => $settings->getValue( "plugin_{$oName1}_enabled" ,1 ,null, true ),   // 是否啟用該 plug-in
            );
        }

        /**
         *  {$oName3} plugin is enabled or not ( by blog settings )
         */
        public function getEnabled( $blog )
        {
            $settings = $this->getPluginSettings( $blog );
            return $settings['plugin{$oName3}Enabled'];
        }

    }

?>