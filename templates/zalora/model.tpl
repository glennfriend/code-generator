<?php

include_once 'base/BaseModel.php';

/**
 *
 */
class {$mName3} extends BaseModel
{
    const CACHE_{$oName7}         = 'cache_{$oName5}';
    const CACHE_{$oName7}_ALL     = 'cache_{$oName5}_all';
    const CACHE_{$oName7}_USER_ID = 'cache_{$oName5}_user_id';

    /**
     *  get db object by record
     *  @param  record
     *  @return {$oName3} object
     */
    public function recordToObject( $record )
    {
        $row = $record->attributes;
        $object = new {$oName3}();
{foreach $vName5 as $key => $val}
{if $fieldType.$key=="timestamp" || $fieldType.$key=="date" || $fieldType.$key=="datetime"}
        $object->set{$vName3.$key}{$vName3.$key|space_even} ( strtotime($row['{$vName5.$key}'])  );
{elseif $val=="properties"}
        $object->set{$vName3.$key}{$vName3.$key|space_even} ( unserialize($row['{$vName5.$key}']) );
{else}
        $object->set{$vName3.$key}{$vName3.$key|space_even} ( $row['{$vName5.$key}']{$vName5.$key|space_even:23} );
{/if}{/foreach}
        return $object;
    }

    /* ================================================================================
        write database
    ================================================================================ */

    /**
     *  add {$oName3}
     *  @param {$oName3} object
     *  @return insert id or false
     */
    public function add{$oName3}( $object )
    {
        $insertId = $this->_addObject( $object, true );
        if ( !$insertId ) {
            return false;
        }

        $object = $this->get{$oName3}( $inserId );
        if ( !$object ) {
            return false;
        }

        $this->_preChangeHook( $object );
        return $insertId;
    }

    /**
     *  update {$oName3}
     *  @param {$oName3} object
     *  @return int
     */
    public function update{$oName3}( $object )
    {
        $result = $this->_updateObject( $object );
        if ( !$result ) {
            return false;
        }
        $this->_preChangeHook( $object );
        return $result;
    }

    /**
     *  delete {$oName3}
     *  @param int id
     *  @return boolean
     */
    public function delete{$oName3}( $id )
    {
        $object = $this->get{$oName3}($id);
        if ( !$object || !$this->_deleteObject($id) ) {
            return false;
        }
        $this->_preChangeHook( $object );
        return true;
    }

    /**
     *  pre change hook, first remove cache, second do something more
     *  about add, update, delete
     *  @param object
     */
    public function _preChangeHook( $object )
    {
        // first, remove cache
        $this->_removeCache( $object );

        // second do something
        // 因為自身修改的影響, 必須要修改其它資料表記錄的欄位值
        /*
            // 例如 add article comment , 則 article of num_comments field 要做更新
            $article = $object->getArticle();
            $article->setNumComments( $this->getNumArticleComments( $article->getId() ) );
            $articles = new Articles();
            $articles->updateArticle( $article );
        */

    }

    /**
     *  remove cache
     *  @param object
     */
    protected function _removeCache( $object )
    {
        if ( $object->getId() >= 1 ) {
            $cacheKey = $this->getFullCacheKey( $object->getId(), {$mName3}::CACHE_{$oName7} );
            Yii::app()->cache->delete( $cacheKey );
        }

        /*
        $allCacheKey = $this->getFullCacheKey( '_ALL', {$mName3}::CACHE_{$oName7}_ALL );
        Yii::app()->cache->delete( $allCacheKey );

        $userIdCacheKey = $this->getFullCacheKey( $object->getUserId(), {$mName3}::CACHE_{$oName7}_USER_ID );
        Yii::app()->cache->delete( $userIdCacheKey );
        */
    }


    /* ================================================================================
        access database
    ================================================================================ */

    /**
     *  get {$oName3} by id
     *  @param  int id
     *  @return object or false
     */
    public function get{$oName3}( $id, $userId=-1, $status={$oName3}::STATUS_ALL )
    {
        $object = $this->_getObject( 'id', $id, {$mName3}::CACHE_{$oName7} );
        if ( -1 !== $userId && $object->getUserId() !== $userId ) {
            return false;
        }
        if ( {$oName3}::STATUS_ALL !== $status && $object->getStatus() !== $status ) {
            return false;
        }
        return $object;
    }

    /**
     *  find many {$oName3}
     *  @param
     *  @return objects or empty array
     */
    public function find{$mName3}( $opt=array() )
    {
        $opt += array(
            'userId'       => -1,
            'status'       => {$oName3}::STATUS_ALL,
            'searchKey'    => '',
            'order'        => '`id` DESC',
            'page'         => 1,
            'itemsPerPage' => APPLICATION_ITEMS_PER_PAGE
        );

        $objects = $this->_getByFind{$mName3}Option( $opt );
        return $objects;
    }

    /**
     *  get count by "find{$mName3}" method
     *  @return int
     */
    public function getNum{$mName3}( $opt=array() )
    {
        $opt += array(
            'userId'       => -1,
            'status'       => {$oName3}::STATUS_ALL,
            'searchKey'    => ''
        );

        return $this->_getByFind{$mName3}Option( $opt, true );
    }

    /**
     *  _getByFind{$mName3}Option
     *
     *  "find{$mName3}" and "getNum{$mName3}" SQL query
     *
     *  @return objects or record total
     */
    protected function _getByFind{$mName3}Option( $opt=array(), $isGetCount=false )
    {
        $where  = array();
        $params = array();

        if ( -1 != $opt['userId'] ) {
            $where[] = '`user_id` = :user_id';
            $params[':user_id'] = $opt['userId'];
        }
        if ( {$oName3}::STATUS_ALL != $opt['status'] ) {
            $where[] = '`status` = :status';
            $params[':status'] = $opt['status'];
        }
        if ( '' !== $opt['searchKey'] ) {
            $where[] = '(`name` LIKE :searchKey OR `description` LIKE :searchKey)';
            $params[':searchKey'] = '%'. $opt['searchKey'] .'%';
        }

        if ( !$isGetCount ) {

            $limit = '';
            if ( -1 !== $opt['page'] ) {
                $opt['page'] = (int) $opt['page'];
                if ( $opt['page'] == 0 ) {
                    $opt['page'] = 1;
                }
                $limit = "LIMIT ". ($opt['page']-1)*$opt['itemsPerPage'] .",". $opt['itemsPerPage'];
            }

            $condition = array(
                'condition' => join(' AND ',$where),
                'params'    => $params,
                'order'     => $opt['order'],
            );
            return $this->_findObjectsByMethod( 'get{$oName3}', $condition, $opt['page'], $opt['itemsPerPage'] );
          //return $this->_findObjects( $condition, $opt['page'], $opt['itemsPerPage'] );

        }
        else {

            $condition = array(
                'condition' => join(' AND ',$where),
                'params'    => $params,
            );
            return $this->_getNumObjects( $condition );

        }

    }


}

