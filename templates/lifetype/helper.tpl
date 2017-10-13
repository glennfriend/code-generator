<?php

    /**
     *  helper utils
     */    
    class Plugin{$oName3}Utils
    {ldelim}

        /**
         *  add data process
         *  PS. the method are include web request !!
         */   
        public function addData() {ldelim}

            

        {rdelim}

        /**
         *  blog redirect 
         *  @return boolean
         */
        public function redirect( $articleId ) {ldelim}

            $articles = new Articles();
            $article = $articles->getArticle( $articleId );
            if( !$article ) {ldelim}
                return false;
            {rdelim}

            $rg = $this->_blogInfo->getBlogRequestGenerator();
          //$rg = $article->getBlogInfo()->getBlogRequestGenerator();
            $rg->setXHTML( false );

            $postPermalink = $rg->postPermalink( $article );

            if( Request::isXHR() ) {ldelim}
                $view = new AjaxView();
                $this->_view = new AjaxViewRenderer( $view );
                $this->_view->setResult( $postPermalink );
                $this->_view->setSuccess( true );
                $this->_view->setMessage( $this->_locale->tr('success') );
                $this->setCommonData();
            {rdelim} else {ldelim}
                $this->_view = new RedirectView( $postPermalink );
            {rdelim}

            return true ;
        {rdelim}

        /**
         *  log
         */
        function writeLog( $log , $isDate=true ) {ldelim}

            $filePath = PLOG_CLASS_PATH.'tmp/' );
            if( !File::exists( $filePath ) ) {ldelim}
                File::createDir( $filePath, 0755 );
            {rdelim}

            if($isDate) {ldelim}
                $log = date('Y-m-d H:i:s - ').$log;
            {rdelim}

            $logName = $filePath .'plugin.log';
            $file = new File( $logName );
            $file->open('a+');
            $file->write($log."\n");
            $file->close();

        {rdelim}

        /**
         *  send email
         *  @return boolean
         */
        function sendEmailToBlogOwner( $blog, $subject, $content )
        {ldelim}

            $blogOwnerEmail = $blog->getOwnerInfo()->getEmail();
            $locales = new Locales();
            $blogLocale = $locales->getLocale( $blog->getSettings()->getValue('locale') );

            $message = new EmailMessage();
            $message->setCharset( 'utf-8' );
            $message->setBody( $content );
            $message->setSubject( $subject );
            $message->AddBCC( $blogOwnerEmail );
            $message->setFrom( 'noreply@ilc.edu.tw' );
            $message->setFromName( 'ilcBlog' );
            $message->setMimeType( 'text/html' );

            //send mail
            set_time_limit( 60 );
            $emailService = new EmailService();
            $result = $emailService->sendMessage( $message );

            return true;

        {rdelim}

    {rdelim}

?>