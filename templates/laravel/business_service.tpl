<?php
declare(strict_types = 1);
namespace App\Service\{$obj->upperCamel()};

use DB;
use Exception;
use App\Entities\{$obj->upperCamel()};
use App\Entities\{$mod->upperCamel()};

/**
 * {$obj->upperCamel()} Service
 *
 */
class {$obj->upperCamel()}Service
{

    public function __construct({$mod->upperCamel()} ${$mod})
    {
        $this->{$mod} = ${$mod};
    }

    /**
     * get
     *
     * @param int ${$obj->lowerCamel()}Id
     * @return {$obj->upperCamel()}|null
     * @throws Exception
     */
    public function get(int ${$obj->lowerCamel()}Id): ?{$obj->upperCamel()}
    {
        try {
            ${$obj} = $this->{$mod}->get(${$obj->lowerCamel()}Id);
            if (! ${$obj}) {
                return null;
            }

            $this->postHook(${$obj});
        }
        catch (Exception $e) {
            throw new Exception($e->getMessage());
        }

        return ${$obj};
    }

    /**
     * add
     *
     * @param {$obj->upperCamel()} $newObject
     * @return {$obj->upperCamel()}|null
     * @throws Exception
     */
    public function add({$obj->upperCamel()} $newObject): ?{$obj->upperCamel()}
    {
        if (! $this->validate($newObject)) {
            return null;
        }

        DB::beginTransaction();

        try {
            ${$obj} = $this->{$mod}->add($newObject);
            if (! ${$obj}) {
                return null;
            }

            $this->postHook(${$obj});
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
    public function update({$obj->upperCamel()} ${$obj}): bool
    {
        if (! $this->validate(${$obj})) {
            return false;
        }

        DB::beginTransaction();

        try {
            if (! $this->{$mod}->update(${$obj})) {
                return false;
            }

            $this->postHook(${$obj});
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
    public function delete($id): bool
    {
        ${$obj} = $this->{$mod}->get($id);
        if (! ${$obj}) {
            return true;
        }

        DB::beginTransaction();

        try {
            if (! $this->{$mod}->delete($id)) {
                return false;
            }

            $this->postHook(${$obj});
        }
        catch (Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }

        DB::commit();
        return true;
    }

    /* --------------------------------------------------------------------------------
        private
    -------------------------------------------------------------------------------- */

    /**
     * 通常用於檢查有沒有資格 寫入/修改/刪除 資料
     * 可能會影響 add, update, delete
     *
     * @param {$obj->upperCamel()} $object
     * @return bool
     */
    protected function validate({$obj->upperCamel()} ${$obj}): bool
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
    protected function postHook({$obj->upperCamel()} ${$obj})
    {
        /*
            例如 add article comment , 則 article of num_comments field 要做更新

            $article = $object->getArticle();
            $article->setNumComments( $this->getNumArticleComments( $article->getId() ) );
            $articles = new Articles();
            $articles->updateArticle($article);

            $this->updateSearchTable();
        */
    }

    /**
     *  update search table
     */
    /*
    protected function updateSearchTable({$obj->upperCamel()} ${$obj})
    {
        $this->search______->rebuild(${$obj}->getId());
    }
    */


}
