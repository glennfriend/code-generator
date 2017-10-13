<?php
declare(strict_types = 1);
namespace App\Model;
use App\Model\{$obj->upperCamel()} as {$obj->upperCamel()};

/**
 *  {$mod->upperCamel()} dao
 */
class {$mod->upperCamel()} extends \ZendModel2
{
    /**
     *  table name
     */
    protected $tableName = '{$tableName}';

    /**
     *  get method
     */
    protected $getMethod = '{$obj->get()}';

    /**
     * get db object by database record
     * @param array $row
     * @param array $row
     * @return {$obj->upperCamel()}
     */
    public function mapRow($row)
    {
        $object = new {$obj->upperCamel()}();
{foreach $tab as $key => $field}
{if $field.ado->type=="timestamp" || $field.ado->type=="date" || $field.ado->type=="datetime"}
        $object->{$field.name->set()}{$key|space_even} ( strtotime($row['{$field.ado->name}']){$key|space_even:16} );
{elseif $key=="properties"}
        $object->{$field.name->set()}{$key|space_even} ( unserialize($row['{$field.ado->name}']){$key|space_even:15} );
{else}
        $object->{$field.name->set()}{$key|space_even} ( $row['{$field.ado->name}']{$field.ado->name|space_even:28} );
{/if}{/foreach}
        return $object;
    }

    /* ================================================================================
        basic write function
    ================================================================================ */

    /**
     * add
     *
     * @param {$obj->upperCamel()} $object
     * @return {$obj->upperCamel()} || null
     */
    public function add{$obj->upperCamel()}({$obj->upperCamel()} $object)
    {
        $insertId = $this->addObject($object, true);
        if (!$insertId) {
            return null;
        }

        $object = $this->{$obj->get()}($insertId);
        if (!$object) {
            return null;
        }

        $this->writeHook($object);
        return $object;
    }

    /**
     * update
     *
     * @param {$obj->upperCamel()} $object
     * @return int effect row count total
     */
    public function update{$obj->upperCamel()}({$obj->upperCamel()} $object)
    {
        $result = $this->updateObject($object);
        if (!$result) {
            return 0;
        }
        $this->removeCache($object);

        $object = $this->{$obj->get()}($object->getId());
        $this->writeHook($object);
        return (int) $result;
    }

    /**
     * delete
     *
     * @param int id
     * @return boolean
     */
    public function delete{$obj->upperCamel()}($id)
    {
        $object = $this->{$obj->get()}($id);
        if (!$object) {
            // 原本資料就不存在, 預期會是 true 的值
            return true;
        }
        if (!$this->deleteObject($id)) {
            return false;
        }

        $this->writeHook($object);
        $this->removeCache($object);
        return true;
    }

    /**
     *  大部份的關連資料會做在 Business Layer
     *  不影響其它資料的, 才會在這裡處理
     *  例如 log
     */
    protected function writeHook({$obj->upperCamel()} $object)
    {
        // write log
    }

    /* ================================================================================
        basic read function
    ================================================================================ */

    /**
     * get by id
     * @param  int id
     * @return object or false
     */
    public function {$obj->get()}($id)
    {
        $object = $this->getObject('id', $id);
        if (!$object) {
            return false;
        }
        return $object;
    }
    public function {$obj->get()}($id, $userId='', $status={$obj->upperCamel()}::STATUS_ALL)
    {
        $object = $this->getObject('id', $id);
        if (!$object) {
            return false;
        }
        if ('' !== $userId && $object->getUserId() !== $userId) {
            return false;
        }
        if ({$obj->upperCamel()}::STATUS_ALL !== $status && $object->getStatus() !== $status) {
            return false;
        }
        return $object;
    }

******************** 以上請二選一 ********************


    /**
     *  remove cache
     *  NOTE: 上面建立了多少 cache key, 這裡就要移除相同數量的 cache
     *
     *  @param object
     */
    protected function removeCache({$obj->upperCamel()} $object)
    {
        if ($object->getId() <= 0) {
            return;
        }

        $cacheKey = $this->getFullCacheKey($object->getId(), 'id');
        CacheBrg::remove($cacheKey);
    }

    /* ================================================================================
        find {$mod->upperCamel()} and get count
        通用型的 find, 管理界面使用
    ================================================================================ */

    /**
     * find many {$obj->upperCamel()}
       @param array $values find names
       @param array $opt options
       @return objects or empty array
     */
    public function find{$mod->upperCamel()}(Array $values, $opt=[])
    {
        $opt += [
            'serverType' => \ZendModel::SERVER_TYPE_MASTER,
            'page' => 1,
            'order' => [
                'id' => 'DESC',
            ],
        ];
        return $this->find{$mod->upperCamel()}Real($values, $opt);
    }

    /**
     *  get count by "find{$mod->upperCamel()}" method
     *  @return int
     */
    public function numFind{$mod->upperCamel()}($values, $opt=[])
    {
        $opt += [
            'serverType' => \ZendModel::SERVER_TYPE_MASTER,
        ];
        return $this->find{$mod->upperCamel()}Real($values, $opt, true);
    }

    /**
     *  find 實際處理的程式
     *
     *      該程式只單純處理單一個 table
     *      組合型的會另外建立其它程式來處理
     *
     *  資料比對的邏輯
     *
     *      字串比對 name = "value"
     *          "name" => "john"    => 只顯示名字完全比對為 "john" 的資料
     *          "name" => ""        => 顯示沒有名字的資料
     *          "name" => null      => 略過欄位, 資料的比對
     *
     *      字串搜尋 name like %value%
     *          "name" => "jonh"    => 只要名字中有 john 就顯示該資料
     *          "name" => ""        => 全部顯示 --> like %%
     *          "name" => null      => 略過欄位, 資料的比對
     *
     *  @return objects or record total
     */
    protected function find{$mod->upperCamel()}Real(Array $vals, $opt=[], $isGetCount=false)
    {
        // validate 欄位 白名單
        $map = [
{foreach $tab as $key => $field}
            '{$field.name->lowerCamel()}' {$field.name->lowerCamel()|space_even} => '{$field.name->lower('_')}',
{/foreach}
        ];
        \ZendModelWhiteListHelper::perform($vals, $map, $opt);
        $select = $this->getDbSelect();

        /*
            $select->where->and
                ->in($field['tags'], explode(',', $opt['tags']));
                ->like($field['name'], '%'.$opt['name'].'%' );
                ->equalTo($field['id'], $opt['id']);

                lessThan                <
                lessThanOrEqualTo       <=
                greaterThan             >
                greaterThanOrEqualTo    >=

            $select
                ->where
                ->and
                ->nest
                    ->like($field['favor'], '%'. $favors[0] .'%')
                    ->or
                    ->like($field['favor'], '%'. $favors[1] .'%')
                ->unnest
            ;
        */

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
            return $this->findObjects($select, $opt);
        }
        return $this->numFindObjects($select);
    }

    /* ================================================================================
        extends
    ================================================================================ */

}

