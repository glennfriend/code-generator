<?php

/**
 *  {$mod->upperCamel()}
 */
class {$mod->upperCamel()} extends ZendModel
{
    /**
     * cache
     *
     * @var string
     */
    const CACHE_{$obj->upper('_')} = 'cache_{$obj->lower('_')}';

    /**
     * table name
     *
     * @var string
     */
    protected $tableName = '{$mod->lower('_')}';

    /**
     * get method
     *
     * @var string
     */
    protected $getMethod = '{$obj->get()}';

    /**
     * get db object by record
     * @param array $row
     * @return {$obj->upperCamel()}
     */
    public function mapRow($row)
    {
        $object = new {$obj->upperCamel()}();
{foreach $tab as $key => $field}
{if $field.ado->type=="timestamp" || $field.ado->type=="date" || $field.ado->type=="datetime"}
        $object->{$field.name->set()}{$key|space_even} (strtotime($row['{$field.ado->name}']){$key|space_even:11});
{elseif $key=="properties"}
        $object->{$field.name->set()}{$key|space_even} (unserialize($row['{$field.ado->name}']){$key|space_even:10});
{elseif $key=="attribs"}
        $object->{$field.name->set()}{$key|space_even} (json_decode($row['{$field.ado->name}'], true));
{else}
        $object->{$field.name->set()}{$key|space_even} ($row['{$field.ado->name}']{$field.ado->name|space_even:23});
{/if}{/foreach}
        return $object;
    }

    /* ================================================================================
        write database
    ================================================================================ */

    /**
     * add {$obj->upperCamel()}
     *
     * @param {$obj->upperCamel()} $object
     * @return {$obj->upperCamel()} || null
     */
    public function add{$obj->upperCamel()}({$obj->upperCamel()} $object): ?{$obj->upperCamel()}
    {
        $insertId = $this->addObject($object, true);
        if (! $insertId) {
            return null;
        }

        $object = $this->{$obj->get()}($insertId);
        if (! $object) {
            return null;
        }

        $this->preChangeHook($object);
        return $object;
    }

    /**
     *  update
     *
     *  @param {$obj->upperCamel()} $object
     *  @return int effect row count total
     */
    public function update{$obj->upperCamel()}({$obj->upperCamel()} $object)
    {
        $result = $this->updateObject($object);
        if (! $result) {
            return 0;
        }

        $this->preChangeHook($object);
        return (int) $result;
    }

    /**
     *  delete
     *
     *  @param int id
     *  @return boolean
     */
    public function delete{$obj->upperCamel()}($id)
    {
        $object = $this->{$obj->get()}($id);
        if (! $object) {
            // 原本資料就不存在, 預期會是 true 的值
            return true;
        }
        if (! $this->deleteObject($id)) {
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
    public function preChangeHook({$obj->upperCamel()} $object)
    {
        // first, remove cache
        $this->removeCache($object);
    }

    /**
     * remove cache
     *
     * @param object
     */
    protected function removeCache({$obj->upperCamel()} $object)
    {
        if ($object->getId() <= 0) {
            return;
        }

        $cacheKey = $this->getFullCacheKey($object->getId(), {$mod->upperCamel()}::CACHE_{$obj->upper('_')});
        CacheBrg::remove($cacheKey);
    }


    /* ================================================================================
        read access database
    ================================================================================ */

    /**
     * get {$obj->upperCamel()} by id
     *
     * @param int $id
     * @return {$obj->upperCamel()} or null
     */
    public function {$obj->get()}($id): ?{$obj->upperCamel()}
    {
        $object = $this->getObject('id', $id, {$mod->upperCamel()}::CACHE_{$obj->upper('_')});
        if (! $object) {
            return null;
        }
        return $object;
    }

    /**
     * get enable {$obj->upperCamel()} by id
     *
     * @param int $id
     * @return {$obj->upperCamel()} or null
     */
    public function getEnable{$obj->upperCamel()}($id): ?{$obj->upperCamel()}
    {
        $object = $this->{$obj->get()}($id);
        if (! $object) {
            return null;
        }
        if ($object->getStatus() !== {$obj->upperCamel()}::STATUS_ENABLE) {
            return null;
        }
        return $object;
    }

    /* ================================================================================
        find {$mod->upperCamel()} and get count
        通用型的 find, 管理界面使用
    ================================================================================ */

    /**
     * find many {$obj->upperCamel()}
     * @param array $opt
     * @return {$obj->upperCamel()}[] or empty array
     */
    public function find{$mod->upperCamel()}(array $opt)
    {
        $opt += array(
            '_order'                => 'id,DESC',
            '_page'                 => 1,
            '_itemsPerPage'         => conf('db.items_per_page')
        );
        return $this->find{$mod->upperCamel()}Real( $opt );
    }

    /**
     * get count by "find{$mod->upperCamel()}" method
     * @return int
     */
    public function numFind{$mod->upperCamel()}(array $opt)
    {
        // $opt += array();
        return $this->find{$mod->upperCamel()}Real($opt, true);
    }


    /**
     * find{$mod->upperCamel()} option
     * @return {$obj->upperCamel()}[] or record total
     */
    protected function find{$mod->upperCamel()}Real($opt=array(), $isGetCount=false)
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
                '_serverType',
            ]
        ];

        ZendModelWhiteListHelper::validateFields($opt, $list);
        ZendModelWhiteListHelper::filterOrder($opt, $list);
        ZendModelWhiteListHelper::fieldValueNullToEmpty($opt);

        $select = $this->getDbSelect();

        /*
        TODO: 組合式的請不要在這裡使用
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
                ->in($field['tags'], explode(',', $opt['tags']));
                ->like($field['name'], '%'.$opt['name'].'%');
                ->equalTo($field['id'], $opt['id']);

                lessThan                <
                lessThanOrEqualTo       <=
                greaterThan             >
                greaterThanOrEqualTo    >=

            $select->where->and
                ->nest
                    ->like($field['favor'], '%'. $favors[0] .'%')
                    ->or
                    ->like($field['favor'], '%'. $favors[1] .'%')
                ->unnest
        */

{foreach $tab as $key => $field}
{if $field.ado->type=="text"}
        if (isset($opt['{$key}'])) {
            $select->where->and->like($field['{$key}'], '%'.$opt['{$key}'].'%');
        }
{else}
        if (isset($opt['{$key}'])) {
            $select->where->and->equalTo($field['{$key}'], $opt['{$key}']);
        }
{/if}
{/foreach}

        if (! $isGetCount) {
            return $this->findObjects($select, $opt);
        }
        return $this->numFindObjects($select, $opt);
    }


    /* ================================================================================
        search {$mod->upperCamel()} and get count
        集中於一個欄位的搜尋, 主要於前台使用, 使用 or 搜尋方式
    ================================================================================ */

    /**
     *  search many {$obj->upperCamel()}
     *  @param  option array
     *  @return {$obj->upperCamel()}[] or empty array
     */
    public function search{$mod->upperCamel()}(array $opt)
    {
        $opt += array(
            '_searchKey'    => '',
            '_order'        => 'id DESC',
            '_page'         => 1,
            '_itemsPerPage' => conf('db.items_per_page')
        );
        return $this->search{$mod->upperCamel()}Real($opt);
    }

    /**
     *  get count by "search{$mod->upperCamel()}" method
     *  @return int
     */
    public function numSearch{$mod->upperCamel()}(array $opt)
    {
        $opt += array(
            '_searchKey' => ''
        );
        return $this->search{$mod->upperCamel()}Real($opt, true);
    }

    /**
     *  search{$mod->upperCamel()} option
     *  @return {$obj->upperCamel()}[] or record total
     */
    protected function search{$mod->upperCamel()}Real(array $opt, $isGetCount=false)
    {
        $select = $this->getDbSelect();

        if ('' !== $opt['_searchKey']) {
            $value = '%'. $opt['_searchKey'] .'%';
            $select->where->nest
                ->or->equalTo( 'email',            $opt['_searchKey']      )
                ->or->like(    'name',        '%'. $opt['_searchKey'] .'%' )
                ->or->like(    'description', '%'. $opt['_searchKey'] .'%' );
        }

        if (! $isGetCount) {
            return $this->searchObjects($select, $opt);
        }
        return $this->numSearchObjects($select);
    }

    /* ================================================================================

    ================================================================================ */

    /**
     *  update search table
     */
    protected function _updateSearchTable(${$obj})
    {
        // 請注意 sql 的 security

        $table = '{$obj->lowerCamel("_")}_search_xxxxs';
        $id = ${$obj}->getId();

        // delete sql
        $select = $this->getDbSelectTable( $table );
        $select->where->equalTo( '{$obj->lowerCamel("_")}_id', $id );
        $result = $this->query( $select );
        while( $row = $result->next() ) {

            $delete = new Zend\Db\Sql\Delete($table);
            $delete->where(array(
                 '{$obj->lowerCamel("_")}_id' => $id,
            ));
            $this->execute($delete);

        }

        // insert sql
        $data = ${$obj}->get??????????();
        if ( $data ) {
            foreach ( $data as $key => $value ) {
                $insert = new Zend\Db\Sql\Insert($table);
                $insert->values(array(
                     'field_name' => $key,
                     'field_name' => $value,
                ));
                $this->execute($insert);
            }
        }

    }

    /* ================================================================================
        extends
    ================================================================================ */

}

