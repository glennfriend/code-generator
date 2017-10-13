<?php

/**
 *
 */
class {$mod->upperCamel()} extends ZendModel
{
    const CACHE_{$obj->upper('_')}         = 'cache_{$obj->lower('_')}';
    const CACHE_{$obj->upper('_')}_ALL     = 'cache_{$obj->lower('_')}_all';
    const CACHE_{$obj->upper('_')}_USER_ID = 'cache_{$obj->lower('_')}_user_id';

    /**
     *  table name
     */
    protected $tableName = '{$tableName}';

    /**
     *  get method
     */
    protected $getMethod = '{$obj->get()}';

    /**
     *  get db object by record
     *  @param  row
     *  @return TahScan object
     */
    public function mapRow( $row )
    {
        $object = new {$obj->upperCamel()}();
{foreach $tab as $key => $field}
{if $field.ado->type=="timestamp" || $field.ado->type=="date" || $field.ado->type=="datetime"}
        $object->{$field.name->set()}{$key|space_even} ( strtotime($row['{$field.ado->name}']){$key|space_even:11} );
{elseif $key=="properties"}
        $object->{$field.name->set()}{$key|space_even} ( unserialize($row['{$field.ado->name}']){$key|space_even:10} );
{else}
        $object->{$field.name->set()}{$key|space_even} ( $row['{$field.ado->name}']{$field.ado->name|space_even:23} );
{/if}{/foreach}
        return $object;
    }

    /* ================================================================================
        write database
    ================================================================================ */

    /**
     *  add {$obj->upperCamel()}
     *  @param {$obj->upperCamel()} object
     *  @return insert id or false
     */
    public function add{$obj->upperCamel()}($object)
    {
        $insertId = $this->addObject($object, true);
        if (!$insertId) {
            return false;
        }

        $object = $this->{$obj->get()}($insertId);
        if (!$object) {
            return false;
        }

        $this->preChangeHook($object);
        return $insertId;
    }

    /**
     *  update {$obj->upperCamel()}
     *  @param {$obj->upperCamel()} object
     *  @return int
     */
    public function update{$obj->upperCamel()}($object)
    {
        $result = $this->updateObject($object);
        if (!$result) {
            return 0;
        }

        $this->preChangeHook($object);
        return (int) $result;
    }

    /**
     *  delete {$obj->upperCamel()}
     *  @param int id
     *  @return boolean
     */
    public function delete{$obj->upperCamel()}(int $id)
    {
        $object = $this->{$obj->get()}($id);
        if ( !$object || !$this->deleteObject($id) ) {
            return false;
        }

        $this->preChangeHook($object);
        return true;
    }

    /**
     *  pre change hook, first remove cache, second do something more
     *  about add, update, delete
     *  @param object
     */
    public function preChangeHook($object)
    {
        // first, remove cache
        $this->removeCache($object);

        // second do something
        // 因為自身修改的影響, 必須要修改其它資料表記錄的欄位值
        /*
            // 例如 add article comment , 則 article of num_comments field 要做更新
            $article = $object->getArticle();
            $article->setNumComments( $this->getNumArticleComments( $article->getId() ) );
            $articles = new Articles();
            $articles->updateArticle($article);
        */
    }

    /**
     *  remove cache
     *  @param object
     */
    protected function removeCache($object)
    {
        if ( $object->getId() <= 0 ) {
            return;
        }

        $cacheKey = $this->getFullCacheKey( $object->getId(), {$mod->upperCamel()}::CACHE_{$obj->upper('_')} );
        CacheBrg::remove( $cacheKey );

        /*
            $cacheKey = $this->getFullCacheKey( '_ALL', {$mod->upperCamel()}::CACHE_{$obj->upper('_')}_ALL );
            CacheBrg::remove( $cacheKey );

            $cacheKey = $this->getFullCacheKey( $object->getUserId(), {$mod->upperCamel()}::CACHE_{$obj->upper('_')}_USER_ID );
            CacheBrg::remove( $cacheKey );
        */
    }


    /* ================================================================================
        read access database
    ================================================================================ */

    /**
     *  get {$obj->upperCamel()} by id
     *  @param  int id
     *  @return object or false
     */
    public function {$obj->get()}( $id, $userId='', $status={$obj->upperCamel()}::STATUS_ALL )
    {
        $object = $this->getObject( 'id', $id, {$mod->upperCamel()}::CACHE_{$obj->upper('_')} );
        if ( !$object ) {
            return false;
        }
        if ( '' !== $userId && $object->getUserId() !== $userId ) {
            return false;
        }
        if ( {$obj->upperCamel()}::STATUS_ALL !== $status && $object->getStatus() !== $status ) {
            return false;
        }
        return $object;
    }

    /* ================================================================================
        find {$mod->upperCamel()} and get count
        通用型的 find, 管理界面使用
    ================================================================================ */

    /**
     *  find many {$obj->upperCamel()}
     *  @param  option array
     *  @return objects or empty array
     */
    public function find{$mod->upperCamel()}($opt=[])
    {
        $opt += [
            '_order'               => 'id,DESC',
            '_page'                => 1,
            '_itemsPerPage'        => Config::get('db.items_per_page')
        ];
        return $this->find{$mod->upperCamel()}Real( $opt );
    }

    /**
     *  get count by "find{$mod->upperCamel()}" method
     *  @return int
     */
    public function numFind{$mod->upperCamel()}($opt=[])
    {
        // $opt += [];
        return $this->find{$mod->upperCamel()}Real($opt, true);
    }

    /**
     *  find{$mod->upperCamel()} option
     *  @return objects or record total
     */
    protected function find{$mod->upperCamel()}Real($opt=[], $isGetCount=false)
    {
        // validate 欄位 白名單
        $list = [
            'fields' => [
{foreach $tab as $key => $field}
                '{$field.name->lowerCamel()}' {$field.name->lowerCamel()|space_even} => '{$field.name->lower('_')}',
{/foreach}
            ],
            'option' => [
                '_order',
                '_page',
                '_itemsPerPage',
            ]
        ];

        ZendModelWhiteListHelper::validateFields($opt, $list);
        ZendModelWhiteListHelper::filterOrder($opt, $list);
        ZendModelWhiteListHelper::fieldValueNullToEmpty($opt);

        $select = $this->getDbSelect();

        /*
        TODO: 組合型的請不要在這裡使用
        $select
            ->from(
                array('main' => $this->tableName),
                array()
            )
            ->join(
                array('t2' => 'table_2'),
                'main.id = t2.main_id',
                array()
            ->join(
                array('t3' => 'table_3'),
                'main.id = t3.main_id',
                array()
            )
        ;
        */

        //
        $field = $list['fields'];

        /*
            $select->where->and
                ->in( $field['tags'], explode(',', $opt['tags']) );
                ->like($field['name'], '%'.$opt['name'].'%' );
                ->equalTo( $field['id'], $opt['id'] );

                lessThan                <
                lessThanOrEqualTo       <=
                greaterThan             >
                greaterThanOrEqualTo    >=

            $select
                ->where
                ->and
                ->nest
                    ->like( $field['favor'], '%'. $favors[0] .'%' )
                    ->or
                    ->like( $field['favor'], '%'. $favors[1] .'%' )
                ->unnest
            ;
        */

{foreach $tab as $key => $field}
{if $field.ado->type=="text"}
        if ( isset($opt['{$key}']) ) {
            $select->where->and->like( $field['{$key}'], '%'.$opt['{$key}'].'%' );
        }
{elseif $field.ado->type=="varchar"}
        if ( isset($opt['{$key}']) ) {
            以下請二選一
            $select->where->and->equalTo( $field['{$key}'], $opt['{$key}'] );
            $select->where->and->like( $field['{$key}'], '%'.$opt['{$key}'].'%' );
        }
{else}
        if ( isset($opt['{$key}']) ) {
            $select->where->and->equalTo( $field['{$key}'], $opt['{$key}'] );
        }
{/if}
{/foreach}

        if ( !$isGetCount ) {
            return $this->findObjects( $select, $opt );
        }
        return $this->numFindObjects( $select );
    }



    /* ================================================================================
        
    ================================================================================ */

    /**
     *  update search table
     *
     *  請注意 sql 的 security !!
     */
    protected function _updateSearchTable(${$obj})
    {
        $table = '{$obj->lowerCamel("_")}_search_xxxxs';
        $mainField = '{$obj->lowerCamel("_")}_id';
        $id = ${$obj}->getId();

        // delete sql
        $select = $this->getDbSelectTable($table);
        $select->where->equalTo( $mainField, $id );
        $result = $this->query( $select );
        if ( $result ) {
            while( $row = $result->next() ) {

                $delete = new Zend\Db\Sql\Delete($table);
                $delete->where([
                     $mainField => $id,
                ]);
                $this->execute($delete);

            }
        }

        // insert sql
        $data = ${$obj}->get??????????();
        if ( $data ) {
            foreach ( $data as $key => $value ) {
                $insert = new Zend\Db\Sql\Insert($table);
                $insert->values([
                     $mainField     => $id,
                     'field_name??' => $key,
                     'field_name??' => $value,
                ]);
                $this->execute($insert);
            }
        }

    }

    /**
     *  xxxxxxxxxx option by SQL query 
     *  @return objects or record total
     */
    protected function xxxxxxxxxx($opt=[])
    {
        $this->error = null;

        // 請注意 pure sql 的 security 

        // default
        $opt += [
            '_param1'       => '',
            '_param2'       => '',
            '_order'        => 'id DESC',
            '_page'         => 1,
            '_itemsPerPage' => Config::get('db.items_per_page')
        ];

        $sql =<<<EOD
            SELECT  id
            FROM    `{ldelim}$this->tableName{rdelim}`
            WHERE   field1 = ?
            AND     field2 = ?
EOD;
        $values = [
            $opt['_param1'],
            $opt['_param2'],
        ];

        try {
            $adapter   = $this->getAdapter();
            $statement = $adapter->query($sql, $values);
            $results   = $statement->execute();
        }
        catch( Exception $e ) {
            $this->error = $e;
            return false;
        }

        if (!$results) {
            return [];
        }

        $objects = [];
        $getMethod = $this->getMethod;
        while ($row = $results->next()) {
            $objects[] = $this->$getMethod($row['id']);
        };

        return $objects;
    }

    /* ================================================================================
        extends
    ================================================================================ */

}

