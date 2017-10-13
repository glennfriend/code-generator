<?php
/*
    <<請完成以下工作後, 刪除該區塊的程式>>

        (1) 修改 build() && buildAll() 的程式碼

        (2) 請到目標 Models 的 preChangeHook() 建立以下程式碼

            // rebuild search table
            SearchTable::factory('{$searchTable->upperCamel()|substr:6}')->rebuild( $object );

        (3) 搜尋程式碼

            SearchTable::factory('{$searchTable->upperCamel()|substr:6}')->find(array(
                'field1' => 'value1',
                'field2' => 'value2',
            ));

*/

/**
 *  {$searchTable->upperCamel()}
 *      - search table
 *
 *  該 search table 使用於 .......
 *
 *
 */
class {$searchTable->upperCamel()} extends SearchBase
{
    const TABLE      = '{$searchTable->lower('_')}';
    const MASTER_KEY = '{$obj->lower('_')}_id';

    // --------------------------------------------------------------------------------
    // custom
    // --------------------------------------------------------------------------------

    /**
     *  建立搜尋程式碼
     */
    public function find( Array $option=array() )
    {
        $option += array(
            $this::MASTER_KEY => '',
        );

        $select = $this->getSelect();
        $select->where($option);

        $result = $this->query($select);
        if( !$result ) {
            return array();
        }

        $objects = array();
        ${$mod->lowerCamel()} = new {$mod->upperCamel()}();
        while( $row = $result->next() ) {
            $objects[] = ${$mod->lowerCamel()}->getOrderItem( $row[$this::MASTER_KEY] );
        };
        return $objects;
    }

    // --------------------------------------------------------------------------------
    // rebuild
    // --------------------------------------------------------------------------------

    public function generatorRebuildAll()
    {
        ${$mod->lowerCamel()} = new {$mod->upperCamel()}();
        $count = ${$mod->lowerCamel()}->numFind{$mod->upperCamel()}();
        $itemsPerPage = self::ITEMSPERPAGE;

        // clean all
        $this->truncate();

        // build
        $page = ceil( $count/$itemsPerPage);
        for ( $i=1; $i<=$page; $i++ )
        {
            $option = array(
                '_order' => 'id ASC',
                '_page' => $i,
                '_itemsPerPage' => $itemsPerPage,
            );
            $my{$mod->upperCamel()} = ${$mod->lowerCamel()}->find{$mod->upperCamel()}($option);
            foreach ( $my{$mod->upperCamel()} as $orderItem ) {
                yield $orderItem->getId();
                $this->rebuild($orderItem);
            }
        }
    }

    /**
     *  重建一組 (單筆或多筆) 資料
     *      - rebuild row
     *      - model add,update,delete hook this
     *      - Zend\Db\Sql\Insert 不吃 null, 若無資料請給予 空字串
     *
     *  @param db-object
     */
    public function rebuild( ${$obj->lowerCamel()} )
    {
        // delete
        $this->delete(array(
             '{$obj->lower('_')}_id' => ${$obj->lowerCamel()}->getId(),
        ));

        // insert
        $this->insert(array(
             '{$obj->lower('_')}_id'     => ${$obj->lowerCamel()}->getId(),
             '{$obj->lower('_')}_field2' => ${$obj->lowerCamel()}->getProperty('field2',''),
             '{$obj->lower('_')}_field3' => ${$obj->lowerCamel()}->getProperty('field3',''),
        ));

        // insert
        // ....
    }

}
