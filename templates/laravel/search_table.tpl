<?php
namespace App\Extend\SearchTable;

use DB;
use Model\SearchTable\SearchBase;
use App\Db\{$mod->upperCamel()};


/**
 * Search Table
 */
class Search{$mod->upperCamel()}
{
    /**
     *
     */
    use SearchBase;

    /**
     *
     */
    const TABLE      = 'search_{$tableName->lower('_')}';
    const MASTER_KEY = '{$obj->lower('_')}_id';

    /**
     * 依照需求, 重新建立 一筆或多筆 供搜尋使用的資料
     *      - delete one or many
     *      - insert one or many
     *
     * @param ${$obj}Id
     */
    public static function rebuild(${$obj}Id)
    {
        ${$mod->lowerCamel()} = new {$mod->upperCamel()}();
        ${$obj} = ${$mod->lowerCamel()}->get(${$obj}Id);
        if (! ${$obj}) {
            return;
        }

        //
        $masterKey   = static::MASTER_KEY;
        $masterValue = ${$obj}->getId();

        // delete
        // !!!!!!!!!!!! 內容請改成 array !!??
        static::_delete($masterKey, $masterValue);

        /*
        // check insert condition
        $isInsert = ${$obj}->getProperty('is_insert_extends');
        $isInsert = ${$obj}->getAttrib('is_insert_extends');
        if (! $isInsert) {
            return;
        }
        */

        // build row
        $row = [
            'id'                    => 0,
            $masterKey              => (string) $masterValue,
            'link_aaaa_id'          => (string) ${$obj}->getAttrib('xxxxxx'),
            'link_bbbb_id'          => (string) ${$obj}->getAttrib('xxxxxx'),
            'tag_name'              => (string) ${$obj}->getAttrib('xxxxxx'),
            'full_name'             => (string) ${$obj}->getAttrib('xxxxxx'),
            'email_hostname'        => (string) ${$obj}->getAttrib('xxxxxx'),
            'user_age'              => (string) ${$obj}->getAttrib('xxxxxx'),
            'image_mime_type'       => (string) ${$obj}->getAttrib('xxxxxx'),
            'user_gender_convert'   => (string) (${$obj}->getGender()==1) ? "male" : "female"),
            'price_scope_convert'   => (string) (${$obj}->getPrice()>=1000) ? "expensive" : "cheap"),
            'status_convert'        => (string) (${$obj}->getStatus()==1) ? "enable" : "disable"),
            'popular_article_topic' => (string) ${$obj}->getBlog()->getPopularArticle()->getTopic(),
            'popular_article_id'    => (string) ${$obj}->getBlog()->getPopularArticle()->getId(),
            'popular_article_view'  => (string) ${$obj}->getBlog()->getPopularArticle()->getTheNumberOfClicks(),
            'referrer_host'         => (string) getUrlHost(${$obj}->getAttrib('referrer'));
        ];
        // pr($row);

        // first insert
        static::_insert($row);

        // extends insert
        // ....
        // static::_insert($row);
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
    public static function reset()
    {
        // clear all
        $originTable = {$mod->upperCamel()}::getModel()->getTable();
        static::_truncate();

        // build all
        $page = 1;
        $itemsPerPage = 1000;
        while (true) {

            $recordStart = ($page-1) * $itemsPerPage;
            $sql = "select id from `{ldelim}$originTable{rdelim}` where 1 order by id ASC limit ?, ?";
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
                static::rebuild($std->id);
            }

            $page++;
        };

    }

    /* --------------------------------------------------------------------------------
        private
    -------------------------------------------------------------------------------- */

    /**
     * @param $url
     * @return array
     */
    protected static function parseUrlParams($url)
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

}
