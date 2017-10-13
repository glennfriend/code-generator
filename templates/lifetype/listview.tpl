<?php

    /**
     *  View 的部份請處理好 html/ajax 這兩種狀況, 
     *  讓別的程式呼叫時可以方便的使用
     */
    class Plugin{$mName3}ListView extends AdminPluginTemplatedView 
    {ldelim}
        var $_page;

        function Plugin{$mName3}ListView( $blogInfo , $params=Array() )
        {ldelim}
            /*
                在 add , update , delete 等不會有動作 admin view 的情況下直接使用
                AdminTemplatedView (或定自的AdminPluginTemplatedView) 呼叫其它的 template 即可
            */
            if( Request::isXHR()) {ldelim}
                $template = "edit{$mName1}_table";
            {rdelim} else {ldelim}
                $template = "edit{$mName1}";
            {rdelim}
            $this->AdminPluginTemplatedView( $blogInfo , $pluginId='{$oName1}' , $template ); 
            $this->_page = $this->getCurrentPageFromRequest();  // the method in class View

        {rdelim}

        function render()
        {ldelim}
            //如果需要在後台取用 plugin 的資料，請在這裡 assign 
            //${$oName1} = $this->_pm->getPlugin('{$oName1}');  // 外掛id
            //$this->setValue( "pluginEnabled", ${$oName1}->getEnabled() );

            // searchTerms
            $htmlFilter = new HtmlFilter();
            $searchTerms = trim( $this->_request->getFilteredValue('searchTerms', $htmlFilter ) ); // search and pager
            $this->setValue( "searchTerms", $searchTerms );

            ${$mName2} = new {$mName3}();
            $my{$mName3} = ${$mName2}->get{$mName3}ByBlogId( $this->_blogInfo->getId() , $searchTerms , $this->_page );
            $num{$oName3} = ${$mName2}->getNum{$mName3}( $this->_blogInfo->getId() , $searchTerms );
            $this->_setPage( $num{$oName3}, $searchTerms );
            $this->setValue( "{$mName2}", $my{$mName3} );

            //$this->_view->setContentType( TEXT_XML_CONTENT_TYPE );  //output XML
            parent::render();
        {rdelim}

        /**
         *  pager configure, the block have write to view value 
         *  @param dataTotalCount is data count from database-table
         *  @param itemsPerPage is page count
         */
        function _setPage( $dataTotalCount, $searchTerms='', $itemsPerPage = DEFAULT_ITEMS_PER_PAGE )
        {ldelim}
            //page 的 $url->getPageSuffix() 只能用在 blog前台
            //$url = $this->_blogInfo->getBlogRequestGenerator();

            $pager = new Pager( '?op=edit{$mName3}' . '&amp;searchTerms='.$searchTerms . '&amp;blogId='.$this->_blogId . '&amp;page=', 
                                $this->_page,
                                $dataTotalCount,
                                $itemsPerPage );
            $this->setValue( "pager", $pager );
        {rdelim}

    {rdelim}

?>