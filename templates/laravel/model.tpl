<?php
declare(strict_types = 1);
namespace App\Db;

use Illuminate\Database\Eloquent\Model as EloquentModel;
use Model\BaseModel;
use Model\ModelExtendCurd;
use Model\ModelExtendGenAll;
use App\Db\Eloquent\{$obj->upperCamel()}Emodel;
use App\Db\{$obj->upperCamel()};
{foreach from=$tab key=key item=field}
{if $key=='userId'}
use App\Db\User;
{/if}
{/foreach}

/**
 * {$mod->upperCamel()} model
 *
 * @method {$obj->upperCamel()}   vo()
 * @method {$obj->upperCamel()}   add({$obj->upperCamel()} ${$obj->lowerCamel()})
 * @method {$obj->upperCamel()}   update({$obj->upperCamel()} ${$obj->lowerCamel()})
 * @method {$obj->upperCamel()}   delete(int ${$obj->lowerCamel()}Id)
 * @method {$obj->upperCamel()}   get(int ${$obj->lowerCamel()}Id)
 * @method {$obj->upperCamel()}[] getMany(string $fieldName, $value, string $orderBy, int $limit)
 * @method {$obj->upperCamel()}   genAll(string $orderBy)
 */
class {$mod->upperCamel()} extends BaseModel
{
    use ModelExtendCurd;
    use ModelExtendGenAll;

    protected static $valueObjectName = {$obj->upperCamel()}::class;
    protected static $modelObjectName = {$obj->upperCamel()}Emodel::class;
    protected static $cacheFields     = ['id'];

    /**
     * build value object after hook
     */
    // protected static function valueObjectHook(${$obj})
    // {
    //     // {$obj->upperCamel()} append extended info
    //     $user->setAttrib('test_only', 'test_only');
    //
    //     return ${$obj};
    // }






    /* ================================================================================
        find UserLogs and get count
        多欄、針對性的搜尋, 主要在後台方便使用, 使用 and 搜尋方式
    ================================================================================ */


    /* ================================================================================
        extends
    ================================================================================ */

{foreach from=$tab key=key item=field}
{if $key=='userId'}
    /**
     * get {$mod}
     *
     * @param $userId
     * @return array
     */
    public static function get{$mod->upperCamel()}ByUserId($userId): array
    {
        return static::getMany('user_id', $userId);
    }
{/if}
{/foreach}


}
