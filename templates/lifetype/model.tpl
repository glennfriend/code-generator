<?php
    lt_include( PLOG_CLASS_PATH."class/dao/model.class.php" );
    lt_include( PLOG_CLASS_PATH."plugins/{$oName1}/class/dao/{$oName1}.class.php" );
    /*
         DAO Constant for Cache , 有關 Cache 的事情請注意:
         1. 取得資料時, 請取 Cache 資料, 如果沒有 Cache 資料請新增 Cache
         2. 刪除資料時, 如果資料有設定 auto_increment 時不一定要刪除資料, 因為資料並不會再讀取到, 只是占空間
         3. 更新資料時, 請刪除跟這筆資料有關的所有 Cache , 不用重建 Cache , 使用者在取得資料會重建 Cache
         4. 新增資料時, 請刪除跟這筆資料有關的所有 Cache , 尤於資料已存在, 可以選擇順便新增 Cache , 不處置亦可
         5. 在建立或刪除 Cache 時, 請注意以以狀況
            a. Cache 資料只有一筆 + 要清 Cache 重建 => 例如 blog 更新一篇文章, 首頁一定要更新
            b. Cache 資料只有一筆 + 不需重建        => 例如 blog 新增一篇文章, 舊文章並不需要更動
            c. Cache 資料不止一筆 + 資料有異動      => 例如 blog 新增一篇文章, 在分類頁計數頁年頁月頁都要更新, 如果還不同月則一定要更新兩個月的頁面以上.

        ※ 本程式要對 CACHE 處理的事
        1. 取得資料:
        2. 刪除資料:
        3. 更新資料:
        4. 新增資料:
    */
    define( "CACHE_{$oName4}",           "cache_{$oName1}" );
    define( "CACHE_{$oName4}_ALL",       "cache_{$oName1}_all" );
    define( "CACHE_{$oName4}_BY_BLOGID", "cache_{$oName1}_by_blogid" );

    /**
     *
     *
     */
    class {$mName3} extends Model
    {
        public function {$mName3}()
        {
            $this->Model();
            $this->table = $this->getPrefix()."{$daoName}"; // 這個地方請修改成真正的 table name
        }

        /**
         *  mapRow use database field
         */
        public function mapRow( $row ) 
        {
            //properties
            if( !$row["properties"] ) {ldelim}
                $row["properties"] = serialize(Array());
            {rdelim}
            $row["properties"] = unserialize( $row["properties"] );

            ${$oName2} = new {$oName3}( {foreach $vName5 as $key => $val}{if $val@index!=0}                $row["{$vName5.$key}"],{/if}

{/foreach}
                $row["{$vName5[0]}"]
            );
{foreach from=$status item=obj}
{foreach $vName1 as $key => $val}
{if $obj->name == $vName5.$key}
            ${$oName2}->set{$vName3.$key}( $row["{$vName5.$key}"] );
{/if}
{/foreach}
{/foreach}
            return ${$oName2};
        }

        /**
         *  get search string for sql
         *  ps. "class/dao/model.class.php" getMany(), getAll() use the "getSearchConditions" function
         *  @see Model::getSearchConditions
         *  @param searchTerms search in db field
         *  @return sql
        public function getSearchConditions( $searchTerms ) 
        {
            $searchTerms = SearchEngine::adaptSearchString( $searchTerms );
            if( !trim($searchTerms) ) {ldelim}
                return '';
            {rdelim}
            ↓
            ↓這裡必須要修改 ☆★☆★☆★☆★☆★☆
            ↓最後一個 "OR" 請刪除
            ↓
            return "
{foreach $vName5 as $key => $val}
{if $fieldType.$key=='text' or $fieldType.$key=='varchar'}
                    ( `{$val}` {$val|space_even:10} LIKE '%{ldelim}$searchTerms{rdelim}%' ) OR 
{/if}
{/foreach}
            " ;
        }
         */
        /**
         *  get table count , getNumItems function for model class
         *  @return integer
        public function getNum{$mName3}BySearchConditions( $blogId , $searchTerms='' ) 
        {ldelim}
            $blogId = SearchEngine::adaptSearchString( $blogId );
            $searchTermsString = $this->getSearchConditions($searchTerms);
            if($searchTermsString) {ldelim}
                $data = " (`blog_id`='{ldelim}$blogId{rdelim}' AND ( {ldelim}$searchTermsString{rdelim}) ) ";
            {rdelim} else {ldelim}
                $data = " (`blog_id`='{ldelim}$blogId{rdelim}') ";
            {rdelim}
            return $this->getNumItems( $this->table, $data );
        {rdelim}
         */

        //------------------------------------------------------------------------------------------------------------------------
        // normal get 
        //------------------------------------------------------------------------------------------------------------------------
        /**
         *  get
         *  @return object , or FALSE
         */
        public function get{$oName3}( $id, $blogId=-1 , $status = {$oName4}_STATUS_ALL ) 
        {ldelim}
            $my{$oName3} = $this->get( "id", $id, CACHE_{$oName4} );  //table field, key value, cache
            if( !$my{$oName3} ) {ldelim}
                return Array();
            {rdelim}
            if( $blogId != -1 ) {ldelim}
                if( $my{$oName3}->getBlogId() != $blogId ) {ldelim}
                    return Array();
                {rdelim}
            {rdelim}
            /*
            注意! {$oName4}_STATUS_ALL 並沒有由本程式產生, 必須手動撰寫
            if( $status != {$oName4}_STATUS_ALL ) {ldelim}
                if( $my{$oName3}->getStatus() != $status ) {ldelim}
                    return Array();
                {rdelim}
            {rdelim}
            */
            return $my{$oName3};

        {rdelim}
        /**
         *  某些情況下需要在發現沒有資料的情況下，新增一筆資料進來,
         *  一般來說像是 "需要update,不需要insert" 的邏輯狀況下(1對0/1 的 資料表), 例如 計數器 or 下載次數 or 有一個計算資料總數的table 等....
         *
         *  get + call add
         *  @return object , or FALSE
         */
        /*
        public function get{$oName3}( $id ) 
        {ldelim}
            $my{$oName3} = $this->get( "id", $id, CACHE_{$oName4} );
            if( !$my{$oName3} ) {ldelim}
                ${$mName2} = new {$mName3}();
                ↓
                ↓這裡必須要修改 ☆★☆★☆★☆★☆★☆
                ↓
                ${$oName2} = new {$oName3}( 初始值或變數, 初始值或變數, ...., Timestamp::getNowTimestamp() );
                $resultId = ${$mName2}->add{$oName3}( ${$oName2} );
                if( !$resultId ) {ldelim}
                    return false;
                {rdelim}
                $my{$oName3} = $this->get( "id", $id, CACHE_{$oName4} );
            {rdelim}
            return $my{$oName3};
        {rdelim}
        */

        /**
         *  get record number, 取得特定參數狀況下的資料筆數
         *  @see get{$mName3}()
         *  @return total int
         */
        public function getNum{$mName3}( $blogId=-1, $searchTerms="" ) 
        {
            $option = array(
                'blogId'        => $blogId,
                '_searchTerms'  => $searchTerms,
            );
            return $this->_getByQuery($option,true);
        }
        /**
         *  get all, 取得所有的資料, 本功能包含 search
         *  @return objects array , or empty array
         */
        public function get{$mName3}( $blogId=-1, $searchTerms="", $page=1, $itemsPerPage=DEFAULT_ITEMS_PER_PAGE ) 
        {
            // no cache
            $option = array(
                'blogId'        => $blogId,
                '_searchTerms'  => $searchTerms,
                '_page'         => $page,
                '_itemsPerPage' => $itemsPerPage,
            );
            return $this->_getByQuery($option);
        }
        /**
         *  取得所有的資料, 通常用在只有 admin 能使用的功能上
         *  get all
         *  @return object , or empty array
         */
        /*
        public function get{$mName3}( $searchTerms="", $page=-1, $itemsPerPage=DEFAULT_ITEMS_PER_PAGE ) 
        {
            ${$mName2} = $this->getAll(
                "all",
                CACHE_{$oName4}_ALL,
                Array(CACHE_{$oName4} => "getId"),
                Array("id" => "DESC"),
                $searchTerms,
                $page,
                $itemsPerPage
            );

            if( !${$mName2} ) {
                return Array();
            }
            return ${$mName2};
        }
        */

        /**
         *  get by blog_id , 本程式包含 CACHE 功能
         *  @return object array , or empty array
         */
        public function get{$mName3}ByBlogId( $blogId, $page=-1, $itemsPerPage=DEFAULT_ITEMS_PER_PAGE )
        {
            $all = $this->_cache->getData( $blogId, CACHE_{$oName4}_BY_BLOGID );
            if( !$all ) {
                $option = array(
                    'blogId'        => $blogId,
                );
                $all = $this->_getByQuery($option);
                $this->_cache->setData( $blogId, CACHE_{$oName4}_BY_BLOGID, $all );
            }

            if( $page<0 || !$all ) {
                return $all;
            }

            if( $page==0 ) {
                $page=1;
            }
            $start = (($page - 1) * $itemsPerPage );
            $dbObjects = array_slice( $all, $start, $itemsPerPage );
            return $dbObjects;

        }
        /**
         *  get by blog_id
         *  @return object array , or empty array
         */
        /*
        public function get{$mName3}ByBlogId( $blogId, $searchTerms="", $page=-1, $itemsPerPage=DEFAULT_ITEMS_PER_PAGE )
        {
            //getMany( $key, $value, $cacheId, $itemCaches = null, $sorting = Array(),
            //         $searchTerms = "", $page = -1, $itemsPerPage )
            $my{$mName3} = $this->getMany(
                "blog_id" , $blogId , CACHE_{$oName4}_BY_BLOGID , Array(CACHE_{$oName4}=>"getId") , Array("id"=>"DESC"),
                $searchTerms="" , $page , $itemsPerPage );
            if( !$my{$mName3} ) {ldelim}
                return Array();
            {rdelim}
            return $my{$mName3};
        }
        */

        //------------------------------------------------------------------------------------------------------------------------
        // normal add update delete
        //------------------------------------------------------------------------------------------------------------------------
        /**
         *  add
         *  @return insert_id , or FALSE
         */
        public function add{$oName3}( ${$oName2} ) 
        {ldelim}
            //$this->_cache->setData( ${$oName2}->getId(), CACHE_{$oName4}, ${$oName2} ); //將物件加入Cache→ 標示號碼, CacheName, 資料物件
            if(  $resultId = $this->add( ${$oName2}, Array( CACHE_{$oName4} => "getId" ))  ) {ldelim}
                $this->_pre{$oName3}ChangeHook( ${$oName2} );
                return $resultId ;
            {rdelim}
            return false;
        {rdelim}

        /**
         *  update
         *  @return boolean
         */
        public function update{$oName3}( ${$oName2} ) 
        {ldelim}
            if( $this->update( ${$oName2} ) ) {ldelim}
                $this->_pre{$oName3}ChangeHook( ${$oName2} );
                return true;
            {rdelim}
            return false;
        {rdelim}

        /**
         *  delete
         *  @return boolean
         */
        public function delete{$oName3}( $id ) 
        {ldelim}
            $my{$oName3} = $this->get{$oName3}( $id );
            if(  $my{$oName3}  &&  $this->delete( "id", $id  )) {ldelim}
                $this->_pre{$oName3}ChangeHook( $my{$oName3} );
                return true;
            {rdelim}
            return false;
        {rdelim}

        /**
         *  delete by blog_id
         *  如果 刪除資料 by blogId , 請記得 by id 的 cache 並沒有刪除,
         *  但是如果資料的 id 是 自動新增 的情況就沒有關系, 因為 舊的id 將不會再被新增, 所以也不再會被讀取
         *  但是如果刪除的 資料id 有可能重新建立, 請記得就要把 cache 清除
         *
         *  @return boolean
         */
        public function delete{$mName3}ByBlogId( $blogId ) 
        {
            $my{$mName3} = $this->get{$mName3}( $blogId );
            if( $my{$mName3} && $this->delete( "blog_id", $blogId ) ) {
                $allOk = true;
                foreach( $my{$mName3} as $my{$oName3} ) {
                    if( $my{$oName3} ) {
                        $this->_pre{$oName3}ChangeHook( $my{$oName3} );
                    }
                    else {
                        $allOk = false;
                    }
                }
                return $allOk;
            }
            return false;


            /*

            // if( !$this->delete( "blog_id", $blogId ) ) {
            //     return false;
            // }

            $option = array( 'blogId' => $blogId );
            $rowCount = $this->_getByQuery( $option, true );
            $itemPerPage = DEFAULT_ITEMS_PER_PAGE;
            $pageMax = ceil($rowCount/$itemPerPage);
            $isDeleteAllOk = true;

            for( $page=1 ; $page<$pageMax ; $page++ ) {

                $objects = $this->get{$mName3}( $blogId, "", $page, $itemPerPage );
                if( !$objects ) {
                    break;
                }

                foreach( $objects as $object ) {
                    if( !$object ) {
                        $isDeleteAllOk = false;
                        continue;
                    }
                    $this->delete{$oName3}( $object->getId() );
                    $this->_pre{$oName3}ChangeHook( $object );
                }

            }
            return $isDeleteAllOk;

            */

        }

        /**
         *  pre change hook, remove cache, do something more....
         *  about add, update, delete
         *  @param object
         */
        protected function _pre{$oName3}ChangeHook( $object ) 
        {
            // 因為自身修改的影響, 必須要修改其它資料表記錄的欄位值

            /*
            // 例如 add article comment , 則 article num_comments field 要做更新
            // update the article num comments
            $article = $object->getArticle();
            $article->setNumComments( $this->getNumArticleComments( $article->getId() ) );
            $articles = new Articles();
            $articles->updateArticle( $article );
            */

            //
            $this->_removeCache( $object );
        }

        /**
         *  remove cache
         *  @param object
         */
        protected function _removeCache( $object ) 
        {
            if( $object->getId() >= 1 ) {ldelim}
                $this->_cache->removeData( $object->getId(), CACHE_{$oName4} );
            {rdelim}
            $this->_cache->removeData( "_all_",              CACHE_{$oName4}_ALL        );
            $this->_cache->removeData( $object->getBlogId(), CACHE_{$oName4}_BY_BLOGID  );
        }

        /**
         *  reset sub table record count
         *  reset field number, 避免觸發本身的無限迴圈, 請用 pure SQL ( delete, insert, update )
         *  
         *  @param id
         *  @return boolean
         */
        protected function _resetNum??????( $id )
        {
            $id = (int) $id;
            ${$oName2} = $this->get{$oName3}( $id );
            if( !${$oName2} ) {
                return false;
            }

            // select count
            $count = (int) ????????????;

            // update count
            $query = "UPDATE {ldelim}$this->table{rdelim} 
                      SET num_?????? = {ldelim}$count{rdelim}
                      WHERE id = {ldelim}${$oName2}->getId(){rdelim} ";
            $result = $this->Execute( $query );
            if( !$result ) {
                return false;
            }
            
            $this->_removeCache( $object );
            return true;
        }

        //------------------------------------------------------------------------------------------------------------------------
        // search by query
        //------------------------------------------------------------------------------------------------------------------------
        /**
         *  取資料, 含分頁功能, 含搜尋功能
         *  因 Catch 機制, 使得只要取得 id 資料即可, 再用 id 去取資料, 在沒有 cache 以前是不會用這種方式來實作的
         *
         *  注意: 
         *      預設是取得全部資料, 並非是取得部份資料
         *
         *  $isGetTotal = FALSE
         *      @return many object array , or empty array
         *
         *  $isGetTotal = TRUE
         *      @return data count
         */
        protected function _getByQuery( $opt, $isGetTotal=false )
        {
            $opt += Array(
{foreach $vName3 as $key => $val}
{if $fieldType.$key=='text' or $fieldType.$key=='varchar'}
                '{$vName2.$key}'{$vName2.$key|space_even} => ( ISSET($opt['{$vName2.$key}']){$vName2.$key|space_even} ? LtDb::qstr($opt['{$vName2.$key}'])                     {$vName2.$key|space_even} : '' ),
{else}
                '{$vName2.$key}'{$vName2.$key|space_even} => ( ISSET($opt['{$vName2.$key}']){$vName2.$key|space_even} ? LtDb::qstr($opt['{$vName2.$key}'])                     {$vName2.$key|space_even} : -1 ),
{/if}
{/foreach}
                '_startTime'           => ( ISSET($opt['_startTime'])           ? LtDb::qstr($opt['_startTime'])                                : -1 ),
                '_endTime'             => ( ISSET($opt['_endTime'])             ? LtDb::qstr($opt['_endTime'])                                  : -1 ),
                '_searchTerms'         => ( ISSET($opt['_searchTerms'])         ? SearchEngine::adaptSearchString($opt['_searchTerms'])         : '' ),
                '_orderBy'             => ( ISSET($opt['_orderBy'])             ? LtDb::qstr($opt['_orderBy'])                                  : ' id DESC ' ),
                '_page'                => ( ISSET($opt['_page'])                ? LtDb::qstr($opt['_page'])                                     : -1 ),
                '_itemsPerPage'        => ( ISSET($opt['_itemsPerPage'])        ? LtDb::qstr($opt['_itemsPerPage'])                             : DEFAULT_ITEMS_PER_PAGE ),
            );

            $where = Array();
{foreach $vName3 as $key => $val}
{if $val@index==0}
{elseif $fieldType.$key=='int' or $fieldType.$key=='tinyint' or $fieldType.$key=='smallint' or $fieldType.$key=='mediumint' or $fieldType.$key=='bigint'}
            if( $opt['{$vName2.$key}'] {$vName2.$key|space_even} != -1 ) {ldelim} $where[] = "{$vName5.$key|even:25}= '". $opt['{$vName2.$key}'] {$vName2.$key|space_even} ."'";  {rdelim}
{elseif $fieldType.$key=='varchar' or $fieldType.$key=='text'}
            if( $opt['{$vName2.$key}'] {$vName2.$key|space_even} != '' ) {ldelim} $where[] = "{$vName5.$key|even} LIKE '%". $opt['{$vName2.$key}'] {$vName2.$key|space_even} ."%'"; {rdelim}
{elseif $fieldType.$key=='date' or $fieldType.$key=='datetime' or $fieldType.$key=='timestamp'}
            // $opt['{$vName2.$key}']   // {$fieldType.$key} 
{else}
{/if}
{/foreach}

            // NOW() - timestamp , UNIX_TIMESTAMP() - int
            if( $opt['_startTime']            != -1 ) {ldelim} $where[] = "NOW() >=                   '". $opt['_startTime']            ."'"; {rdelim}
            if( $opt['_endTime']              != -1 ) {ldelim} $where[] = "NOW() <                    '". $opt['_endTime']              ."'"; {rdelim}
            if( $opt['_searchTerms']          != '' ) {ldelim}
                $where[] = "(
                    欄位 LIKE '%". $opt['_searchTerms'] ."%' OR
                    欄位 LIKE '%". $opt['_searchTerms'] ."%' OR
                    欄位 LIKE '%". $opt['_searchTerms'] ."%' 
                )";
            {rdelim}

            $where = join(' AND ',$where);
            if( $where != "" ) {ldelim}
                $where= " WHERE $where ";
            {rdelim}

            $from = " FROM {ldelim}$this->table{rdelim} ";

            // get row count
            if( $isGetTotal ) {ldelim}
                $result = $this->Execute( "SELECT COUNT(id) AS total $from $where " );
                if( !$result ) {ldelim}
                    return 0;
                {rdelim}

                $row = $result->FetchRow();
                $number = $row["total"];
                $result->Close();
                return $number;
                //return $result->RecordCount();
            {rdelim}

            $query = " SELECT id $from $where ORDER BY {ldelim}$opt['_orderBy']{rdelim} ";

            if( $opt['_page'] == -1 ) {
                $result = $this->Execute( $query );
            }
            else {
                $result = $this->Execute( $query, $opt['_page'], $opt['_itemsPerPage'] );
            }
            if( !$result ) {
                return Array();
            }

            ${$mName2} = Array();
            while( $row = $result->FetchRow()) {
                array_push( ${$mName2} , $this->get{$oName3}( $row['id'] ));
            }
            $result->Close();
            return ${$mName2};
        }

    }
?>