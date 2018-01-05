<?php

/**
 *  {$mod->upperCamel()}Reports
 */
class {$mod->upperCamel()}Reports
{

    /**
     * [itemStatus] 大於 60 天的計算
     * option by SQL query
     *
     * @param array $vals
     * @param array $opt
     * @param bool $isQueryCount
     * @return array|bool|int
     * @throws Exception
     */
    public function findMoreThan60Days(array $vals=[], array $opt=[], $isQueryCount=false)
    {
        // default
        $vals += [
            // 必要條件
            'dayGreaterThan' => 60, // 大於 ? 天
            // 可選擇條件
            'userEmail' => null,
        ];
        $opt += [
            'page' => 1,
            'per_page' => null,
            'order_by' => [
                ['id', 'DESC'],
            ],
        ];

        // --------------------------------------------------------------------------------
        //  vals convert to condition
        // --------------------------------------------------------------------------------
        $conditionValue = ZendPureSqlModel::arrayFilter([
            'dayGreaterThan' => (int) $vals['dayGreaterThan'],
            'userEmail'      => trim(strip_tags($vals['userEmail'])),
        ]);

        // --------------------------------------------------------------------------------
        //  query
        // --------------------------------------------------------------------------------
        if ($isQueryCount) {
            $select = 'count(m.id) as _total_';
        } else {
            $select = 'm.id';
        }

        $pf = ZendPureSqlModel::getParamFunc();

        // 必要條件
        $condition = <<<EOD
            SELECT {ldelim}$select{rdelim}
            FROM  `order_items` AS `m`
            WHERE ((UNIX_TIMESTAMP() - UNIX_TIMESTAMP(m.create_time)) / 86400) > {ldelim}$pf('dayGreaterThan'){rdelim}
EOD;

        // 可選擇條件
        if (isset($conditionValue['userEmail'])) {
            $condition .= <<<EOD
            AND `m`.`user_email` = {ldelim}$pf('userEmail'){rdelim}
EOD;
        }

        try {
            // execute
            if ($isQueryCount) {
                return ZendPureSqlModel::queryCount($condition, $conditionValue);
            }
            else {
                return ZendPureSqlModel::query($condition, $conditionValue, $opt);
            }
        }
        catch (Exception $e) {
            throw $e;
        }
    }

    // --------------------------------------------------------------------------------
    //  以下這個方式已棄用 !
    // --------------------------------------------------------------------------------
    /**
     * xxxxxxxxxx
     * option by SQL query
     *
     * @param array $opt
     * @param bool $isGetCount
     * @return array|int|mixed - objects or record total
     * @throws Exception
     */
    public function xxxxxxxxxx(array $opt=[], bool $isGetCount=false)
    {
        // default
        $opt += [
            'not_security_val'  => 321,
            '_order'            => 'id DESC',
            '_page'             => 1,
        ];

        if ($isGetCount) {
            $field = 'count(id) AS total';
        }
        else {
            $field = 'id';
        }

        // 請注意 pure sql 的 security
        $sql =<<<EOD
            SELECT  {ldelim}$field{rdelim}
            FROM    `{ldelim}$this->tableName{rdelim}`
            WHERE   not_security_val >= ?
EOD;
        $values = [
            $opt['not_security_val']
        ];

        //
        $this->error = null;
        if ($isGetCount) {

            $total = 0;
            try {
                $adapter   = $this->getAdapter();
                $statement = $adapter->query($sql, $values);
                while ($row = $statement->current()) {
                    $total = $row['total'];
                    break;
                };
            }
            catch (Exception $e) {
                throw new Exception($e);
            }

            return $total;
        }
        else {

            $limit = ZendModelHelper::parseOptionLimit($opt);
            $order = ZendModelHelper::parseOptionOrder($opt);
            $sql .= " " . "{ldelim}$order{rdelim} {ldelim}$limit{rdelim}";

            $objects = [];
            $getMethod = $this->getMethod;
            try {
                $adapter   = $this->getAdapter();
                $statement = $adapter->query($sql, $values);
                while ($row = $statement->current()) {
                    $objects[] = $this->$getMethod($row['id']);
                    $statement->next();
                };
            }
            catch (Exception $e) {
                throw new Exception($e);
            }

            return $objects;
        }

    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

}

