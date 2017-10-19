<?php
namespace SearchTable;

use Yii;

// Yii::import('application.modules.admin.xxxxxx.models.components.*');
// Yii::import('application.modules.admin.xxxxxx.models.*');

/*
    <<請完成以下工作後, 刪除該區塊的程式>>

        (1) 修改 rebuild() && reset() 的程式碼

        (2) 請到目標 Models 的 preChangeHook() 建立以下程式碼

            // rebuild search table
            \SearchTable\Search{$mod->upperCamel()}::rebuild($object->getId());

*/

/**
 * {$mod->upperCamel()}
 *      - build search table data
 *      - origin data for "{$mod->lower('_')}" table
 *
 * Class Search{$mod->lower()}
 * @package SearchTable
 */
class {$mod->upperCamel()} extends SearchBase
{
    /**
     *
     */
    use Library\SearchBase;

    /**
     *
     */
    const TABLE      = 'search_{$mod->lower('_')}';
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
        ${$mod} = new \{$mod->upperCamel()}();
        ${$obj} = ${$mod}->get{$obj->upperCamel()}(${$obj}Id);
        if (! ${$obj}) {
            return;
        }

        $masterKey   = static::MASTER_KEY;
        $masterValue = ${$obj}->getId();

        // delete
        static::_delete([
            $masterKey => $masterValue,
        ]);

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
    }

    /**
     * 依照所需資料, 重新建立所有資料
     *      - truncate table
     *      - insert all
     *      - 會有一段空窗期, 請離線執行這項工作
     *
     * @return \Generator
     */
    public static function reset()
    {
        //
        static::_truncate();

        //
        $page = 1;
        while (true) {
            $options = array_filter([
                '_page'         => $page,
                '_itemsPerPage' => 1000,
                '_order'        => 'id,ASC',
            ]);
            ${$mod} = new \{$mod->upperCamel()}();
            $objects = ${$mod}->find{$mod->upperCamel()}($options);
            if (! $objects) {
                break;
            }

            yield [
                'page'  => $page,
                'from'  => $objects[0]->getId(),
                'to'    => $objects[(count($objects)-1)]->getId(),
            ];

            foreach ($objects as $obj) {
                static::rebuild($obj->getId());
            }

            $page++;
        };
    }

}
