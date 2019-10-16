<?php
declare(strict_types=1);
namespace App\Entities\SearchTable;
// namespace Modules\______\Entities\SearchTable;

use DB;
use Cor\Model\SearchTable\SearchBase;
use Cor\Model\Utility\ArrayKit\Dot;
use App\Db\{$mod->upperCamel()};
// use Modules\____\Entities\{$mod->upperCamel()};


/**
 * Search Table
 */
class {$mod->upperCamel()}
{
    // trait
    use SearchBase;

    //
    const TABLE      = '{$tableName->lower('_')}';
    const MASTER_KEY = '{$obj->lower('_')}_id';     // please modify, is your parent id

    public function __construct({$mod->upperCamel()} ${$mod})
    {
        $this->{$mod} = ${$mod};
    }

    /**
     * 依照需求, 重新建立 一筆或多筆 供搜尋使用的資料
     *      - delete one or many
     *      - insert one or many
     *
     * @param ${$obj}Id
     */
    public function rebuild(${$obj}Id)
    {
        ${$mod} = $this->{$mod}->get(${$obj}Id);
        ${$obj} = ${$mod}->get(${$obj}Id);
        if (! ${$obj}) {
            return;
        }

        //
        $masterKey   = static::MASTER_KEY;
        $masterValue = ${$obj}->getId();

        //
        $this->deleteManyByMasterKey($masterValue);

        // check insert condition
        $attribRaw = ${$mod}->getAttrib('raw');
        if (! $attribRaw) {
            return;
        }
        $get = Dot::factory($attribRaw);
        

        // build row
        $row = [
{foreach from=$tab key=key item=field}
{if $field.ado->type=='tinyint' || $field.ado->type=='int' || $field.ado->type=='smallint' || $field.ado->type=='bigint'}
            '{$field.ado->name}' {$field.ado->name|space_even} => (int)    $get('oooooo.xxxxxx'),
{elseif $field.ado->type=="timestamp" || $field.ado->type=="date" || $field.ado->type=="datetime"}
            '{$field.ado->name}' {$field.ado->name|space_even} =>          date("c", ${$obj}->{$field.name->get()}()),
{else}
            '{$field.ado->name}' {$field.ado->name|space_even} => (string) $get('oooooo.xxxxxx'),
{/if}
{/foreach}
            //
            'link_aaaa_id'          => (string) ${$obj}->getAttrib('xxxxxx'),
            'link_bbbb_id'          => (string) ${$obj}->getAttrib('xxxxxx'),
            'tag_name'              =>          ${$obj}->getAttrib('xxxxxx') ?? null,
            'full_name'             =>          ${$obj}->getAttrib('xxxxxx') ?? null,
            'email_hostname'        => (string) ${$obj}->getAttrib('xxxxxx'),
            'user_age'              => (string) ${$obj}->getAttrib('xxxxxx'),
            'image_mime_type'       => (string) ${$obj}->getAttrib('xxxxxx'),
            'canceled_at'           =>          ($at = $get('meta.canceled_at')) ? date('c', $at) : null,
            'user_gender_convert'   => (string) (${$obj}->getGender()==1) ? "male" : "female"),
            'price_scope_convert'   => (string) (${$obj}->getPrice()>=1000) ? "expensive" : "cheap"),
            'status_convert'        => (string) (${$obj}->getStatus()==1) ? "enable" : "disable"),
            'popular_article_topic' => (string) ${$obj}->getBlog()->getPopularArticle()->getTopic(),
            'popular_article_id'    => (string) ${$obj}->getBlog()->getPopularArticle()->getId(),
            'popular_article_view'  => (string) ${$obj}->getBlog()->getPopularArticle()->getTheNumberOfClicks(),
            'referrer_host'         => (string) getUrlHost(${$obj}->getAttrib('referrer'));
            //
            $masterKey              => (string) $masterValue,
        ];
        $row = $this->arrayRemoveNullValue($row);
        // dd($row);


        // myself insert, or more insert other row
        static::_insert($row);

        // myself update
        // $this->_update($row);
    }

    /**
     * 依照需求, 重新建立所有資料
     *      - truncate table
     *      - insert all
     *      - 會有一段空窗期, 如果該資料被系統使用 (例如有 select), 請離線執行這項工作
     *
     * 另一個未選用的方案
     *      - 不使用 truncate
     *      - 如果是採取從原 table 撈出 ids, 進行逐步的修改, 可能會有機會造成 舊資料殘留 的嚴重問題
     *
     * @return \Generator
     */
    public function reset()
    {
        // clear all
        $originTable = $this->biSources->getModel()->getTable();
        

        $this->_truncate();

        // build all
        $page = 1;
        $itemsPerPage = 1000;
        while (true) {

            $recordStart = ($page-1) * $itemsPerPage;
            $sql = "SELECT id FROM `{ldelim}$originTable{rdelim}` WHERE 1 ORDER BY id ASC LIMIT ?, ?";
            $stds = DB::select($sql, [$recordStart, $itemsPerPage]);
            if (! $stds) {
                break;
            }

            $firstId = $stds[0]->id;
            $lastId  = $stds[(count($stds)-1)]->id;

            yield [
                'page'  => $page,
                'from'  => $firstId,
                'to'    => $lastId,
            ];

            foreach ($stds as $std) {
                $this->rebuild($std->id);
            }

            $page++;
        };

    }

    /* --------------------------------------------------------------------------------
        private
    -------------------------------------------------------------------------------- */

    /**
     * @param int $masterValue
     */
    protected function deleteManyByMasterKey(int $masterValue)
    {
        $masterKey = static::MASTER_KEY;

        // delete many by master key of value
        $this->_delete($masterKey, $masterValue);
    }

    /**
     * @param $url
     * @return array
     */
    /*
    protected function parseUrlParams($url)
    {
        $referInfo = parse_url($url);
        if (!isset($referInfo['query'])) {
            return [];
        }

        $result = [];
        $queryInfo = explode("&", $referInfo['query']);
        foreach ($queryInfo as $itemString) {

            $tmp = explode("=", $itemString);
            if (! $tmp) {
                continue;
            }

            if (1===count($tmp)) {
                $key = $tmp[0];
                $value = null;
            }
            else {
                list($key, $value) = explode("=", $itemString);
            }

            $key = preg_replace('/[^a-zA-Z0-9\_]+/', '', trim($key));
            if (! $key) {
                continue;
            }

            $result[$key] = trim(strip_tags($value));
        }

        return $result;
    }
    */

}
