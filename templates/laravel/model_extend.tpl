<?php

class {$mod->upperCamel()}
{
    /*
        // 測試中
        get     一筆資料
        find    多筆資料
        search  不規則欄位

        // sql_mode
        config()->set('database.connections.mysql.strict', false);
    */


    /* ================================================================================
        extends
    ================================================================================ */

    /**
     * get last
     *
     * @return {$obj->upperCamel()}|null
     */
    public function getLast(): ?{$obj->upperCamel()}
    {
        $model = $this->getModel();
        $eloquent = $model
                    ->where('status', {$obj->upperCamel()}::STATUS_ENABLE)
                    ->orderBy('id', 'DESC')
                    ->first();

        if (! $eloquent) {
           return null;
        }

        return $this->get($eloquent->id);
    }

    /**
     * get last
     *
     * @return {$obj->upperCamel()}|null
     */
    public static function getLast(): ?{$obj->upperCamel()}
    {
        $table = $this->getModel()->getTable();

        $sql = <<<EOD
            select `id`
            from `{ldelim}$table{rdelim}`
            where `status` = ?
            order by id desc
            limit 1
EOD;

        $objects = DB::select($sql, [{$obj->upperCamel()}::STATUS_ENABLE]);
        foreach ($objects as $obj) {
            return static::get($obj->id);
        }

        return null;

        /*
            以下的語法 未經過測試

            注意
            可能要在 database.php config 設定

                'mysql' => [
                    'driver' => 'mysql',
                    ...
                    'options' => [
                        PDO::ATTR_EMULATE_PREPARES => true,
                    ],
                ],

        */

        $sql = <<<EOD
            select `id`
            from `{ldelim}$table{rdelim}`
            where `status` = :status
            order by id desc
            limit 1
EOD;

        $objects = DB::select(DB::raw($sql), [
            'status' => SearchBiSubscriptionPayment::STATUS_ENABLE,
        ]);
        foreach ($objects as $obj) {
            return static::get($obj->id);
        }

        return null;
    }

    /**
     *  get by user_id
     *
     *  @param int user_id
     *  @return {$obj->upperCamel()}|null
     */
    public function {$obj->get()}ByUserId($userId): ?{$obj->upperCamel()}
    {
        $objects = $this->getMany('user_id', $userId);
        if (! $objects) {
            return null;
        }

        return $objects[0];
    }

    /**
     *  find by scope
     *
     *  @return array {$mod->upperCamel()}
     */
    public function findByScope(int $fromId, int $toId): array
    {
        $collection = $this->getModel()
            ->where('id', '>=', $fromId)
            ->where('id', '<=', $toId)
            ->orderBy('id', 'asc')
            ->get();

        if (0 === count($collection)) {
            return [];
        }

        ${$mod} = [];
        foreach ($collection as $model) {
            ${$mod}[] = $this->get($model->id);
        }

        return ${$mod};
    }

    /**
     * @param string $city
     * @param string $stateCode
     * @param int $page
     * @param int $limit
     * @return array
     * @throws Exception
     */
    public function findByScope(string $city, string $stateCode, int $page=1, int $limit=15): array
    {
        $limitCondition = SqlGrammar::limit($page, $limit);

        $sql = <<<EOD
            SELECT  `id`
            FROM    `your_table`
            WHERE   `city` = ?
            AND     `state_code` = ?
            ORDER BY id ASC
            {ldelim}$limitCondition{rdelim}
EOD;

        $ids = [];
        $objects = DB::select($sql, [$city, $stateCode]);
        if (! $objects) {
            return [];
        }
        foreach ($objects as $obj) {
            $ids[] = $obj->id;
        }

        return static::getIds($ids);  // getByIds ??
    }


    /**
     * @param array $options
     * @return {$mod->upperCamel()}[]|Generator
     * @throws Exception
     */
    public function generator(array $options = []): Generator
    {
        $options += [
            'startId'      => 0,
            'itemsPerPage' => 1000,
            'numberOfMax'  => null,     // 欲取得總數
        ];
        $isLastQuery = false;
        $numberOfGetTotal = 0;
        $startId = (int)$options['startId'];
        $limit = (int)$options['itemsPerPage'];

        do {
            if ($options['numberOfMax'] && ($numberOfGetTotal + $options['itemsPerPage']) > $options['numberOfMax']) {
                $isLastQuery = true;
                $limit = $options['numberOfMax'] - $numberOfGetTotal;
            }

            $collection = $this->getModel()
                ->select('id')
                ->where('id', '>=', $startId)
                ->orderBy('id', 'ASC')
                ->limit($limit)
                ->get();

            if ($collection->count() <= 0) {
                break;
            }

            $ids = [];
            foreach ($collection as $model) {
                $ids[] = $model->id;
            }
            foreach ($this->getByIds($ids) as $obj) {
                yield $obj;
            }

            if ($isLastQuery) {
                break;
            }
            if (count($ids) < $limit) {
                break;  // 如果不足 $limit 數量, 表示已取完
            }

            $numberOfGetTotal += count($ids);
            $startId = 1 + (int)array_pop($ids);
        } while (true);

    }

    /**
     * @param string $category
     * @param array $options
     * @return Generator
     * @throws Exception
     */
    public function generatorByCategory(string $category, array $options=[]): Generator
    {
        $options += [
            'startId' => 0,
            'limit'   => 40,
        ];
        $startId = (int) $options['startId'];
        $limit   = (int) $options['limit'];

        do {
            $sql = <<<EOD
            SELECT  `id`
            FROM    `{$mod->lower('_')}`
            WHERE   `id` >= ?
            AND     `category` = ?
            ORDER BY `id` ASC
            LIMIT   {ldelim}$limit{rdelim}
EOD;

            $objects = DB::select($sql, [$startId, $category]);
            if (!$objects) {
                break;
            }
            $ids = [];
            foreach ($objects as $obj) {
                $ids[] = $obj->id;
            }
            foreach (static::getIds($ids) as $obj) {    // getByIds ??
                yield $obj;
            }

            // 如果不足 $limit 數量, 表示已取完
            if (count($ids) < $limit) {
                break;
            }

            //
            $startId = 1 + (int)array_pop($ids);
        } while (true);
    }

    /**
     * count by query
     * 
     * @param string $category
     * @param array $options
     * @return int|null
     */
    public function countByCategory(string $category, array $options=[]): ?int
    {
        $sql = <<<EOD
            SELECT  count(`id`) AS total
            FROM    `{$mod->lower('_')}`
            ...
            ...
            not group by 
            not limit
EOD;

        $objects = DB::select($sql, [$country, $country]);
        if (!$objects || !is_array($objects)) {
            return null;
        }

        return (int)$objects[0]->total;
    }


    public function customExecute()
    {
        die('stop it');

        // step 1
        // 幂等性: no
        $step1 = <<<EOD
            INSERT INTO `name_full_names`
                      (`full_name`,`first_name`,`last_name`,`rank`,`gender_male_percent`)
                SELECT `full_name`,`first_name`,`last_name`,`rank`,`gender_male_percent`
                FROM `name_full_1`
                ORDER BY rank ASC
EOD;

        // step 2
        // 幂等性: yes
        $step2 = <<<EOD
            SET  interactive_timeout        = 600;
            SET  wait_timeout               = 600;
            SET  innodb_lock_wait_timeout   = 600;

            UPDATE `name_full_names` SET rank = id
            WHERE rank IS NULL
            ORDER BY id ASC
            LIMIT 5000000;
EOD;

        //
        $sql = $step2;
        DB::unprepared($sql);
    }



    
    /* ================================================================================
        search {$mod->upperCamel()} and get count
        用於混合的 search, frontend 或是 客製化針對性 的使用
    ================================================================================ */

    /**
     *  search many {$obj->upperCamel()}
     *  @param  option array
     *
     *  @return objects or empty array
     */
    未整理 未整理 未整理 未整理 未整理 未整理
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
    未整理 未整理 未整理 未整理 未整理 未整理
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
     *  custom select SQL query
     *
     *  @return objects or record total
     */
    未整理 未整理 未整理 未整理 未整理 未整理
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
    未整理 未整理 未整理 未整理 未整理 未整理
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

        /* --------------------------------------------------------------------------------
            condition
        -------------------------------------------------------------------------------- */

        $conditionValue = ZendPureSqlModel::arrayFilter([
            'status'            => $status,
            'payment_method'    => $paymentMethod,
            'created_at_start' => $dateStart,
            'created_at_end'   => $dateEnd,
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
            AND   `m`.`created_at`          >= {ldelim}$pf('created_at_start'){rdelim}
            AND   `m`.`created_at`          <= {ldelim}$pf('created_at_end'){rdelim}
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

