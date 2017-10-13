<?php

class {$mod->upperCamel()}
{
    /**
     *
     */
    protected function removeCache()
    {
        // "user_id" cache
        $cacheKey = $this->getFullCacheKey($object->getUserId(), 'user_id');
        CacheBrg::remove($cacheKey);

        // 所有資料在 "_all" 的 cache
        $cacheKey = $this->getFullCacheKey('_all', '_all');
        CacheBrg::remove($cacheKey);
    }

    /* ================================================================================
        basic read function
    ================================================================================ */

    /**
     *  get by user_id
     *  @param  int user_id
     *  @return object or false
     */
    public function {$obj->get()}ByUserId($userId)
    {
        $object = $this->getObject('user_id', $userId);
        if (!$object) {
            return false;
        }
        return $object;
    }

    /**
     *  get all
     *  @return objects or false
     */
    public function getAll{$mod->upperCamel()}()
    {
        // key is '_all'
        ????
    }

    /* ================================================================================
        search {$mod->upperCamel()} and get count
        用於混合的 search, frontend 或是 客製化針對性 的使用
    ================================================================================ */

    /**
     *  search many {$obj->upperCamel()}
     *  @param  option array
     *  @return objects or empty array
     */
    public function search{$mod->upperCamel()}(Array $values, $opt=[])
    {
        $opt += [
            'serverType' => \ZendModel::SERVER_TYPE_MASTER,
            'page' => 1,
            'order' => [
                'id' => 'DESC',
            ],
        ];
        return $this->search{$mod->upperCamel()}Real($values, $opt);
    }

    /**
     *  get count by "search{$mod->upperCamel()}" method
     *  @return int
     */
    public function numSearch{$mod->upperCamel()}(Array $values, $opt=[])
    {
        $opt += [
            'serverType' => \ZendModel::SERVER_TYPE_MASTER,
        ];
        return $this->search{$mod->upperCamel()}Real($values, $opt, true);
    }

    /**
     *  search{$mod->upperCamel()}
     *  該程式用於
     *      - ????
     *
     *  @return objects or record total
     */
    protected function search{$mod->upperCamel()}Real(Array $vals, $opt=[], $isGetCount=false)
    {
        // validate 欄位 白名單
        $map = [
{foreach $tab as $key => $field}
            '{$field.name->lowerCamel()}' {$field.name->lowerCamel()|space_even} => 'main.{$field.name->lower('_')}',
{/foreach}

            'ooooAaaa'              => 't2.aaaa',
            'ooooBbbb'              => 't2.bbbb',
            'ooooCccc'              => 't2.cccc',
        ];
        \ZendModelWhiteListHelper::perform($vals, $map, $opt);
        $select = $this->getDbSelect();
        $select
            ->from(
                array('main' => '{$tableName}'),
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

        //
{foreach $tab as $key => $field}
{if $field.ado->type=="text"}
        if (isset($vals['{$key}'])) {
            $select->where->and->like($map['{$key}'], '%'.$vals['{$key}'].'%');
        }
{elseif $field.ado->type=="varchar"}
        if (isset($vals['{$key}'])) {
            以下請二選一
            $select->where->and->equalTo($map['{$key}'], $vals['{$key}']);
            $select->where->and->like($map['{$key}'], '%'.$vals['{$key}'].'%');
        }
{else}
        if (isset($vals['{$key}'])) {
            $select->where->and->equalTo($map['{$key}'], $vals['{$key}']);
        }
{/if}
{/foreach}

        if (!$isGetCount) {
            return $this->searchObjects($select, $opt);
        }
        return $this->numSearchObjects($select);
    }

    /* ================================================================================

    ================================================================================ */

    /**
     *  update search table
     *
     *  請注意 該呼叫程式要移到 business layer, update 可能還是留在該處
     *  請注意 sql 的 security !!
     */
    protected function _updateSearchTable(${$obj})
    {
        $table = '{$obj->lower("_")}_search_xxxxs';
        $mainField = '{$obj->lower("_")}_id';
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
     *  custom select SQL query
     *
     *  @return objects or record total
     */
    protected function findXxxxxxxxxx(Array, $values, Array $opt=[])
    {
        $this->error = null;

        // default
        $opt += [
            'page' => 1,
        ];
        $orderBy = 'id DESC';

        $sql =<<<EOD
            SELECT   id
            FROM     `{ldelim}$this->tableName{rdelim}`
            WHERE    `user_name` = ?
            AND      `age` >= ?
            ORDER BY {ldelim}$orderBy{rdelim}
EOD;
        $values = [
            $values['userName'],
            $values['age'],
        ];

        try {
            $results = BaseModel::getAdapter()->query($sql, $values);
        }
        catch (\Exception $e) {
            $this->setModelErrorMessage($e->getMessage());
            return false;
        }

        if (!$results) {
            return [];
        }

        // find many
        $objects = [];
        $getMethod = $this->getMethod;
        foreach ($results as $obj) {
            $row = $obj->getArrayCopy();
            $objects[] = $this->$getMethod($row[$this->pk]);
        }

        return $objects;
    }

    /**
     *  getRowsBy______ option by SQL query
     *  @return objects or record total
     */
    protected function getRowsBy______xxxxxx(array $vals=[], array $opt=[], $isQueryCount=false)
    {
        $this->error = null;

        $opt += [
            'page'      => 1,
            'perPage'   => 30,
            'order_by'  => [
                ['m.id', 'ASC'],
            ],
        ];

        // default vals
        $vals += [
            'status'         => '2',
            'payment_method' => null,
            'date_start'     => null,
            'date_end'       => null,
        ];

        // vals filter or convert
        $status         = $vals['status'];
        $paymentMethod  = $vals['payment_method'];
        $dateStart      = $vals['date_start'];
        $dateEnd        = $vals['date_end'];
        if (!$dateStart || !$dateStart) {
            $dateStart  = '2000-01-01';
            $dateEnd    = '2000-01-31';
        }

        // --------------------------------------------------------------------------------
        //  condition
        // --------------------------------------------------------------------------------

        $conditionValue = ZendPureSqlModel::arrayFilter([
            'status'            => $status,
            'payment_method'    => $paymentMethod,
            'create_time_start' => $dateStart,
            'create_time_end'   => $dateEnd,
        ]);

        $querySelect = "SELECT m.*";
        $queryCount  = "SELECT count(*) as _total_";
        $pf = ZendPureSqlModel::getParamFunc();

        // 必須存在的條件
        $condition = <<<EOD
            FROM  `order_invoices` AS `m`
            LEFT JOIN `orders`
            ON    `m`.`order_id`            = `orders`.`id`
            WHERE `m`.`status`              = {ldelim}$pf('status'){rdelim}
            AND   `m`.`payment_method`      = {ldelim}$pf('payment_method'){rdelim}
            AND   `m`.`create_time`        >= {ldelim}$pf('create_time_start'){rdelim}
            AND   `m`.`create_time`        <= {ldelim}$pf('create_time_end'){rdelim}
EOD;

        // 不一定存在的條件
        if (isset($conditionValue['payment_method'])) {
            $condition .= <<<EOD
            AND   `orders`.`payment_method` = {ldelim}$pf('payment_method'){rdelim}
EOD;
        }

        // execute
        try {
            if ($isQueryCount) {
                return ZendPureSqlModel::queryCount($queryCount  . $condition, $conditionValue);
            }
            else {
                return ZendPureSqlModel::query(     $querySelect . $condition, $conditionValue, $opt);
            }
        }
        catch (\Exception $e) {
            // throw $e;
            $this->setModelErrorMessage($e->getMessage());
            return false;
        }

    }

}

