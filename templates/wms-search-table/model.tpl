<?php

/**
 * 附加於其它的 Model, 本身並不會有物件
 */
class None
{

    /* ================================================================================
        Search Table
        find & get count
    ================================================================================ */

    /**
     * find many Object
     *
     * @param array $opt
     * @return Object[] or empty array
     */
    public function find??????By(array $opt)
    {
        $opt += [
            '_order'                => 'id,DESC',
            '_page'                 => 1,
            '_itemsPerPage'         => conf('db.items_per_page')
        ];
        return $this->{$mod->lowerCamel()}Real( $opt );
    }

    /**
     * get count by Search Table
     * @return int
     */
    public function num??????(array $opt)
    {
        // $opt += [];
        return $this->{$mod->lowerCamel()}Real($opt, true);
    }


    /**
     * search table option
     * @return {$obj->upperCamel()}[] or record total
     */
    protected function {$mod->lowerCamel()}Real(array $opt, $isGetCount=false)
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
        $select->from('{$tableName->lower("_")}');
        /*
        OR

        $select
            ->from(
                ['main' => '{$tableName->lower("_")}'],
                []
            )
            ->join(['t2' => 'table_2'], 'main.id = t2.main_id', [])
            ->join(['t3' => 'table_3'], 'main.id = t3.main_id', [])
        ;
        */

        $field = $list['fields'];

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

        if (!$isGetCount) {
            return $this->findObjects($select, $opt, '資料表中輸出物件 id 的欄位名稱 e.g. user_id');
        }
        return $this->numFindObjects($select, $opt);
    }

}

