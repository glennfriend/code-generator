<?php
declare(strict_types = 1);
namespace App\Business\{$obj->upperCamel()};

use DB;
use Exception;
use App\Db\{$obj->upperCamel()};
use App\Db\{$mod->upperCamel()};

/**
 *  {$obj->upperCamel()} Service
 *
 */
class {$obj->upperCamel()}Service
{
    /**
     *  add
     *
     * @param {$obj->upperCamel()} $new{$obj->upperCamel()})
     * @return {$obj->upperCamel()}|null
     * @throws Exception
     */
    public static function add({$obj->upperCamel()} $new{$obj->upperCamel()}): ?{$obj->upperCamel()}
    {
        if (! static::validate($new{$obj->upperCamel()})) {
            return null;
        }

        DB::beginTransaction();

        try {
            ${$obj} = {$mod->upperCamel()}::add($new{$obj->upperCamel()});
            if (! ${$obj}) {
                return null;
            }

            static::postHook(${$obj});
        }
        catch (Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }

        DB::commit();
        return ${$obj};
    }

    /**
     * update
     *
     * @param {$mod->upperCamel()} ${$obj}
     * @return bool
     * @throws Exception
     */
    public static function update({$obj->upperCamel()} ${$obj}): bool
    {
        if (! static::validate(${$obj})) {
            return false;
        }

        DB::beginTransaction();

        try {
            if (! {$mod->upperCamel()}::update(${$obj})) {
                return false;
            }

            static::postHook(${$obj});
        }
        catch (Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }

        DB::commit();
        return true;
    }

    /**
     * delete
     *
     * @param int $id
     * @return bool
     */
    public static function delete($id): bool
    {
        ${$obj} = {$mod->upperCamel()}::get($id);
        if (! ${$obj}) {
            return true;
        }

        DB::beginTransaction();

        try {
            if (! {$mod->upperCamel()}::delete($id)) {
                return false;
            }

            static::postHook(${$obj});
        }
        catch (Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }

        DB::commit();
        return true;
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     * 通常用於檢查有沒有資格 寫入/修改/刪除 資料
     * 可能會影響 add, update, delete
     *
     * @param {$obj->upperCamel()} $object
     * @return bool
     */
    private static function validate({$obj->upperCamel()} ${$obj}): bool
    {
        return true;
    }

    /**
     * 因為自身修改的影響, 必須連動的程式, 修改其它資料
     * 可能會影響 add, update, delete
     * hook 不應該出現錯誤, 必須是容許錯誤的程式
     *
     * @param {$obj->upperCamel()} $object
     */
    private static function postHook({$obj->upperCamel()} ${$obj})
    {
        /*
            例如 add article comment , 則 article of num_comments field 要做更新

            $article = $object->getArticle();
            $article->setNumComments( $this->getNumArticleComments( $article->getId() ) );
            $articles = new Articles();
            $articles->updateArticle($article);
        */
    }

}
