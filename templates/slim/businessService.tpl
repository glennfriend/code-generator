<?php
declare(strict_types = 1);
namespace App\Business\{$obj->upperCamel()};
use Exception;
use App\Model\{$mod->upperCamel()};
use App\Model\{$obj->upperCamel()};

/**
 *  {$obj->upperCamel()} Service
 */
class {$obj->upperCamel()}Service
{
    /**
     *
     */
    protected static $error = null;

    /**
     *  add
     *
     *  @return {$obj->upperCamel()} or null
     */
    public static function add({$obj->upperCamel()} $my{$obj->upperCamel()})
    {
        self::$error = null;

        if (!self::preHook($my{$obj->upperCamel()})) {
            return null;
        }

        //BaseModel::begin();
        //${$mod}->begin();

        try {
            ${$mod} = new {$mod->upperCamel()}();
            ${$obj} = ${$mod}->add{$obj->upperCamel()}($my{$obj->upperCamel()});
            if (!${$obj}) {
                $error = ${$mod}->getModelError();
                throw new Exception($error);
            }

            if (!self::postHook(${$obj})) {
                throw new Exception(self::$error);
            }

            //BaseModel::commit();
            //${$mod}->commit();
            return ${$obj};
        }
        catch (Exception $e) {
            self::$error = $e->getMessage();

            //BaseModel::rollback();
            //${$mod}->rollback();
            return null;
        }

    }

    /**
     *  update
     *  回傳值如果是 int, 即使是 0 也是代表為正確的 update
     *  不正確的狀況會傳回 false
     *
     *  @return mixed, effect row count total or false
     */
    public static function update({$obj->upperCamel()} ${$obj})
    {
        self::$error = null;

        if (!self::preHook(${$obj})) {
            return false;
        }

        //BaseModel::begin();

        try {
            ${$mod} = new {$mod->upperCamel()}();
            $effectRow = ${$mod}->update{$obj->upperCamel()}(${$obj});

            if (!self::postHook(${$obj})) {
                throw new Exception(self::$error);
            }

            //BaseModel::commit();
            return $effectRow;
        }
        catch (Exception $e) {
            self::$error = $e->getMessage();

            //BaseModel::rollback();
            return false;
        }

    }

    /**
     *  delete
     *
     *  @return boolean
     */
    public static function delete($id)
    {
        self::$error = null;

        ${$mod} = new {$mod->upperCamel()}();
        ${$obj} = ${$mod}->get{$obj->upperCamel()}($id);
        if (!self::preHook(${$obj})) {
            return false;
        }

        //BaseModel::begin();

        try {
            ${$mod} = new {$mod->upperCamel()}();
            if (!${$mod}->delete{$obj->upperCamel()}($id)) {
                $error = ${$mod}->getModelError();
                throw new Exception($error);
            }

            if (!self::postHook(${$obj})) {
                throw new Exception(self::$error);
            }

            //BaseModel::commit();
            return true;
        }
        catch (Exception $e) {
            self::$error = $e->getMessage();

            //BaseModel::rollback();
            return false;
        }

    }

    // --------------------------------------------------------------------------------
    //  error message
    // --------------------------------------------------------------------------------

    public static function getError()
    {
        return self::$error;
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     *  before (add, update, delete)
     *      通常在檢查有沒有資格 寫入/修改/刪除 資料
     *
     *  @return boolean
     */
    private static function preHook({$obj->upperCamel()} $object)
    {
        self::$error = null;

        return true;
    }

    /**
     *  after (add, update, delete)
     *      因為自身修改的影響, 必須連動的程式, 修改其它資料
     *
     *  @return boolean
     */
    private static function postHook({$obj->upperCamel()} $object)
    {
        self::$error = null;

        /*
            例如 add article comment , 則 article of num_comments field 要做更新

            $article = $object->getArticle();
            $article->setNumComments( $this->getNumArticleComments( $article->getId() ) );
            $articles = new Articles();
            $articles->updateArticle($article);
        */
        return true;
    }

}
