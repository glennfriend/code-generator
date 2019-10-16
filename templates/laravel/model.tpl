<?php
declare(strict_types=1);
namespace App\Entities;

use Cor\Model\BaseModel;
use Cor\Model\ModelExtendCurd;
use Cor\Model\ModelExtendGenAll;
use App\Entities\Eloquent\{$obj->upperCamel()}Eloquent;
use App\Entities\{$obj->upperCamel()};
{foreach from=$tab key=key item=field}
{if $key=='userId'}
use App\Entities\User;
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

    protected $valueObjectName = {$obj->upperCamel()}::class;
    protected $modelObjectName = {$obj->upperCamel()}Eloquent::class;
    protected $cacheFields     = ['id'];

    /**
     * build value object after hook
     */
    protected function valueObjectHook(${$obj})
    {
        // {$obj->upperCamel()} append extended info
        // $user->setAttrib('test_only', 'test_only');
        return ${$obj};
    }






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
        return $this->getMany('user_id', $userId);
    }
{/if}
{/foreach}


}
