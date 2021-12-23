<?php
declare(strict_types=1);

namespace Modules\______\Molds\SearchTable;
// namespace App\Entities\SearchTable;

use Cor\Mold\Contracts\SearchTableInterface;
use Cor\Mold\SearchTable\SearchBase;
use Cor\Mold\Utility\ArrayKit\Dot;
use Exception;
use Generator;
use Illuminate\Support\Facades\DB;

use Modules\______\Molds\{$mod->upperCamel()};
// use App\Db\{$mod->upperCamel()};

/**
 * Search Table
 * 
 * tips:
 *      - 如果有多個來源表, 只想寫到同一個 search table, 那麼, 請為每一個來源表, 建立一個 SearchTable class, 資料 insert 到同一個 search table
 * 
 */
class {$mod->upperCamel()} implements SearchTableInterface
{
    use SearchBase;

    //
    const TABLE      = 'st_{$tableName->lower('_')}';
    const MASTER_KEY = '{$obj->lower('_')}_id';     // please modify, is your parent id, maybe is unique id

    private {$mod->upperCamel()} ${$mod};

    /**
     * @param {$mod->upperCamel()} ${$mod}
     */
    public function __construct({$mod->upperCamel()} ${$mod})
    {
        $this->{$mod} = ${$mod};
    }

    /**
     * @return {$mod->upperCamel()}
     */
    public function getOriginModel()
    {
        return $this->{$mod};
    }

    /**
     * 依照需求, 重新建立 一筆或多筆 供搜尋使用的資料
     *      - delete one or many
     *      - insert one or many
     *
     * @param {$obj->upperCamel()} ${$obj}
     * @param array $options
     * @throws Exception
     */
    public function myRebuild(${$obj}, array $options = [])
    {
        //
        $masterKey   = self::MASTER_KEY;
        $masterValue = $this->getValueByMasterKey(${$obj}->getId());

        // check insert condition
        if (! $this->isValidate(${$obj})) {
            return;
        }
        $attribRaw = ${$obj}->getAttrib('raw');
        if (! $attribRaw) {
            return;
        }

        // build row
        $row = [
{foreach from=$tab key=key item=field}
{if $key=='id'}
            // '{$field.ado->name}' {$field.ado->name|space_even} => (int)    ${$obj}->getId(),
{elseif $key=='attribs'}
{elseif $field.ado->type=='tinyint' || $field.ado->type=='int' || $field.ado->type=='smallint' || $field.ado->type=='bigint'}
            '{$field.ado->name}' {$field.ado->name|space_even} => (int)    $get('oooooo.xxxxxx'),
{elseif $field.ado->type=="timestamp" || $field.ado->type=="date" || $field.ado->type=="datetime"}
            '{$field.ado->name}' {$field.ado->name|space_even} =>          date("Y-m-d H:i:s", (int) ${$obj}->{$field.name->get()}()),
{else}
            '{$field.ado->name}' {$field.ado->name|space_even} => (string) $get('oooooo.xxxxxx'),
{/if}
{/foreach}
            //
            'link_aaaa_id'          =>          ${$obj}->getAttrib('xxxxxx'),
            'link_bbbb_id'          =>          ${$obj}->getAttrib('xxxxxx'),
            'tag_name'              =>          ${$obj}->getAttrib('xxxxxx'),
            'full_name'             => (string) ${$obj}->getAttrib('xxxxxx'),
            'email_hostname'        =>          ${$obj}->getAttrib('xxxxxx'),
            'user_age'              =>          $get('user.age'),
            'image_mime_type'       =>          $get('image.type'),
            'canceled_at'           =>          ($at = $get('meta.canceled_at')) ? date('Y-m-d H:i:s', (int) $at) : null,
            'user_gender_convert'   => (string) (${$obj}->getGender()==1) ? "male" : "female"),
            'price_scope_convert'   => (string) (${$obj}->getPrice()>=1000) ? "expensive" : "cheap"),
            'status_convert'        => (string) (${$obj}->getStatus()==1) ? "enable" : "disable"),
            'popular_article_id'    => (string) ${$obj}->getBlog()->getPopularArticle()->getId(),
            'popular_article_view'  => (string) ${$obj}->getBlog()->getPopularArticle()->getTheNumberOfClicks(),
            'referrer_host'         => (string) getUrlHost(${$obj}->getAttrib('referrer'));
            //
            $masterKey              => (string) $masterValue,
        ];

        // myself insert, or more insert other row
        // 改成 "資料不存在才 insert" ????
        $this->_insert($row);

        // myself update
        // $this->_update($row);
    }

    /* --------------------------------------------------------------------------------
        private
    -------------------------------------------------------------------------------- */

    protected function isValidate({$obj->upperCamel()} {$obj}): bool
    {
        if ('disabled' === ${$obj}->getStatus()) {
            return false;
        }

        return true;
    }

    /**
     * @param $url
     * @return array
     */
    /*
    protected function parseUrl($url)
    {
        return \Ydin\Url\UrlMake::parse($url);
    }
    */

}
