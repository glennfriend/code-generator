<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Services;
{else        }namespace App\Service\{$obj->upperCamel()};
{/if}

use Exception;
use Throwable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

{if $isModule}
use Modules\{$obj->upperCamel()}\Molds\{$mod->upperCamel()};
use Modules\{$obj->upperCamel()}\Molds\{$obj->upperCamel()};
{else}
use App\Molds\{$mod->upperCamel()};
use App\Molds\{$obj->upperCamel()};
{/if}

/**
 * {$obj->upperCamel()} Service
 *
 */
class {$obj->upperCamel()}Service
{
    private {$mod->upperCamel()} ${$mod};

    public function __construct({$mod->upperCamel()} ${$mod})
    {
        $this->{$mod} = ${$mod};
    }

    // --------------------------------------------------------------------------------
    //  read, search
    // --------------------------------------------------------------------------------

    /**
     * @param int ${$obj->lowerCamel()}Id
     * @return {$obj->upperCamel()}|null
     */
    /*
    public function get(int ${$obj->lowerCamel()}Id): ?{$obj->upperCamel()}
    {
        ${$obj} = $this->{$mod}->get(${$obj->lowerCamel()}Id);
        if (! ${$obj}) {
            return null;
        }

        return ${$obj};
    }
    */

    // --------------------------------------------------------------------------------
    //  create, update, delete
    // --------------------------------------------------------------------------------

    /**
     * @param {$obj->upperCamel()} $newObject
     * @return {$obj->upperCamel()}|null
     * @throws Throwable
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
        }
        catch (Throwable $e) {
            DB::rollBack();
            throw $e;
        }
        DB::commit();

        $this->postHook(${$obj});
        return ${$obj};
    }

    /**
     * @param {$obj->upperCamel()} ${$obj}
     * @throws Throwable
     */
    public function update({$obj->upperCamel()} ${$obj}): void
    {
        if (! $this->validate(${$obj})) {
            return;
        }

        DB::beginTransaction();
        try {
            if (! $this->{$mod}->update(${$obj})) {
                return;
            }
        }
        catch (Throwable $e) {
            DB::rollBack();
            throw $e;
        }
        DB::commit();

        $this->postHook(${$obj});
    }

    /**
     * @param int $id
     * @return bool
     * @throws Throwable
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
        }
        catch (Throwable $e) {
            DB::rollBack();
            throw $e;
        }
        DB::commit();

        $this->postHook(${$obj});
        return true;
    }

    /* --------------------------------------------------------------------------------
        private
    -------------------------------------------------------------------------------- */

    /**
     * 通常用於檢查有沒有資格 寫入/修改/刪除 資料
     * 可能會影響 add, update, delete
     *
     * @param {$obj->upperCamel()} ${$obj}
     * @return bool
     */
    protected function validate({$obj->upperCamel()} ${$obj}): bool
    {
        return true;
    }

    /**
     * 因為自身修改的影響, 必須連動的程式, 修改其它資料
     * 可能會影響 add, update, delete
     * hook 的邏輯理論上必須是完全容錯, 應該要讓 exception 通過, 但是必須留下 log
     * hook 裡面如果是容許錯誤的部份, 可以考慮設計 event 來處理
     * 
     *
     * @param {$obj->upperCamel()} ${$obj}
     */
    protected function postHook({$obj->upperCamel()} ${$obj})
    {
        /*
            例如 add article comment , 則 article of num_comments field 要做更新

            $article = $object->getArticle();
            $article->setNumComments( $this->getNumArticleComments( $article->getId() ) );
            $articles = new Articles();
            $articles->updateArticle($article);
        */
        /*
            $this->updateSearchTable();
        */
    }

    /**
     *  update search table
     */
    /*
    protected function updateSearchTable({$obj->upperCamel()} ${$obj})
    {
        $this->______SearchTable->rebuild(${$obj}->getId());
    }
    */


}
