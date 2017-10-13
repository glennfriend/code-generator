<?php
require_once '{$oName3}.php';

/**
 *  zend db table
 */
class Application_Model_DbTable_{$mName3} extends Zend_Db_Table_Abstract
{
    protected $_name = 'ap_{$oName5}';
}


/**
 *  
 */
class {$mName3} extends BaseMapper
{
    protected $_modelName   = '{$oName3}';
    protected $_dbTableName = 'Application_Model_DbTable_{$mName3}';

    /* ================================================================================
        about model object
    ================================================================================ */

    /**
     *  set mapRow by pure database record
     */
    public function mapRow($row)
    {
{foreach $vName5 as $key => $val}
{if $vName5.$key=="properties"}
        //properties
        is_array($row["properties"])
            ? $row["properties"] = unserialize($row["properties"])
            : $row["properties"] = Array();
{/if}
{/foreach}

        $model = $this->getModel();
{foreach $vName5 as $key => $val}
{if $fieldType.$key=="timestamp" || $fieldType.$key=="date" || $fieldType.$key=="datetime"}
        $model->set{$vName3.$key}{$vName3.$key|space_even} ( strtotime($row['{$vName5.$key}']) );
{else}
        $model->set{$vName3.$key}{$vName3.$key|space_even} ( $row['{$vName5.$key}']{$vName5.$key|space_even} );
{/if}
{/foreach}

        {*
            $model->setCreateDateByString ( $row['create_date']   );
            $model->setUpdateDateByString ( $row['update_date']   );
        *}
        return $model;
    }

    /* ================================================================================
        write database
    ================================================================================ */

    /**
     *  add
     */
    public function add{$oName3}( $model )
    {
        return $this->_save( $model, 'add' );
    }

    /**
     *  update
     */
    public function update{$oName3}( $model )
    {
        return $this->_save( $model, 'update' );
    }

    /* ================================================================================
        access database
    ================================================================================ */

    /**
     *  get
     */
    public function get{$oName3}( $id, $userId=null, $status=null )
    {
        if( null===$status ) {
            $status = {$oName3}::STATUS_ALL;
        }

        $model = $this->_find($id);
        if( {$oName3}::STATUS_ALL !== $status && $model->getStatus() !== $status ) {
            return false;
        }
        if( $userId && $model->getUserId() != $userId ) {
            return false;
        }
        return $model;
    }

    /**
     *  get many
     */
    public function get{$mName3}( $searchKey=null, $page=null, $rowCount=null ) 
    {
        if( null===$page ) {
            $page = 1;
        }
        if( null===$rowCount ) {
            $rowCount = BaseMapper::DEFAULT_ROW_COUNT;
        }

        $opt = Array(
            // TODO: 請確認關聯值
            // 'userId'     => $userId,
            '_searchKey' => $searchKey,
            '_orderBy'   => ' id DESC ',
            '_page'      => $page,
            '_rowCount'  => $rowCount,
        );
        return $this->_getByQuery($opt);
    }

    /**
     *  get count by "get{$mName3}" method
     */
    public function getNum{$mName3}( $searchKey=null ) 
    {
        $opt = Array(
            // TODO: 大致同上
            '_searchKey' => $searchKey,
        );
        return $this->_getByQuery($opt,true);
    }

    /**
     *  get query
     */
    protected function _getByQuery( $opt, $isGetTotal=false )
    {
        $this->_checkOption($opt);
        $opt += Array(
{foreach $vName5 as $key => $val}
{if $fieldType.$key=='int' || $fieldType.$key=='tinyint' || $fieldType.$key=='smallint'}
            '{$vName2.$key}'{$vName2.$key|space_even} => (isset($opt['{$vName2.$key}']){$vName2.$key|space_even} ? (int) ($opt['{$vName2.$key}']){$vName2.$key|space_even} : NULL ),
{else}
            '{$vName2.$key}'{$vName2.$key|space_even} => (isset($opt['{$vName2.$key}']){$vName2.$key|space_even} ?       ($opt['{$vName2.$key}']){$vName2.$key|space_even} : NULL ),
{/if}
{/foreach}

          //'_startDate'           => (isset($opt['_startDate'])           ?       ($opt['_startDate'])           : NULL ),
          //'_endDate'             => (isset($opt['_endDate'])             ?       ($opt['_endDate'])             : NULL ),
            '_searchKey'           => (isset($opt['_searchKey'])           ?       ($opt['_searchKey'])           : NULL ),
            '_orderBy'             => (isset($opt['_orderBy'])             ?       ($opt['_orderBy'])             : ' id DESC ' ),
            '_page'                => (isset($opt['_page'])                ? (int) ($opt['_page'])                : 1 ),
            '_rowCount'            => (isset($opt['_rowCount'])            ? (int) ($opt['_rowCount'])            : BaseMapper::DEFAULT_ROW_COUNT ),
        );

        if( isset($opt['_orderBy']) ) {
            $opt['_orderBy'] = explode(',',$opt['_orderBy']);
        }

        if( isset($opt['_page']) && $opt['_page']<=1 ) {
            $opt['_page'] = 1;
        }

        $where = Array();
{foreach $vName5 as $key => $val}
        if(isset( $opt['{$vName2.$key}']{$vName2.$key|space_even})) { $where[] = $this->getDb()->getAdapter()->quoteInto(' {$vName5.$key} = ? '{$vName5.$key|space_even}, $opt['{$vName2.$key}']{$vName2.$key|space_even} );  }
{/foreach}

      //if(isset( $opt['_startDate']          )) { $where[] = $this->getDb()->getAdapter()->quoteInto(' 日期 >= ? '               , $opt['_startDate']            );  }
      //if(isset( $opt['_endDate']            )) { $where[] = $this->getDb()->getAdapter()->quoteInto(' 日期 < {* > *} ? '               , $opt['_endDate']              );  } 
        if( $opt['_searchKey'] ) {
            // 注意: 特殊符號應該要變更一下 => "%" "_" 之類的
            $searchTerms[] = $this->getDb()->getAdapter()->quoteInto(' 搜尋欄位 LIKE ? ', '%'.$opt['_searchKey'].'%' );
            $searchTerms[] = $this->getDb()->getAdapter()->quoteInto(' 搜尋欄位 LIKE ? ', '%'.$opt['_searchKey'].'%' );
            $searchTerms[] = $this->getDb()->getAdapter()->quoteInto(' 搜尋欄位 LIKE ? ', '%'.$opt['_searchKey'].'%' );
            $where[] = ' ( '. join(' OR ',$searchTerms) . ' ) ';
        }

        // where from array to string
        $whereString = join(' AND ',$where);
        if(!$whereString) {
            $whereString = null;
        }

        // get total
        if( $isGetTotal ) {
            $select = $this->getDb()->select();
            $select->from( $this->getDb(), Array('COUNT(*) AS total') );
            if($whereString) {
                $select->where( $whereString );
            }
            $rows = $this->getDb()->fetchRow($select);
            $row = $rows->toArray();
            return (int) $row['total'];
        }

        //
        //echo $whereString;

        //
        if( NULL === $opt['_page'] ) {
            $rowset = $this->getDb()->fetchAll($whereString, $opt['_orderBy']);
        }
        else {
            $offset = ($opt['_page']-1) * $opt['_rowCount'];
            $rowset = $this->getDb()->fetchAll($whereString, $opt['_orderBy'], $opt['_rowCount'], $offset );
        }
        if( !$rowset ) {
            return NULL;
        }

        $models = Array();
        foreach( $rowset as $row ) {
            $models[] = $this->mapRow( $row->toArray() );
        }
        return $models;

    }

}

