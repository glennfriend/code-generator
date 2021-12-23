<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Molds;
{else        }namespace App\Molds;
{/if}

use Cor\Mold\BaseModel;
use Cor\Mold\ModelExtendCurd;
use Cor\Mold\ModelExtendGenAll;
use Exception;

{if $isModule}use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()}Eloquent;
{else        }use App\Entities\{$obj->upperCamel()}Eloquent;
{/if}

{foreach from=$tab key=key item=field}
{if $key=='userId'}
// use App\Entities\User;
use Modules\{$obj->upperCamel()}\Entities\User;
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
 * @method {$obj->upperCamel()}[] getMany(string $fieldName, $value, array $options)
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







    // --------------------------------------------------------------------------------
    //  extends
    // --------------------------------------------------------------------------------

    /**
     * get {$obj->upperCamel()}
     *
     * @param string $email
     * @return {$obj->upperCamel()}|null
     * @throws Exception
     */
    public function get{$obj->upperCamel()}ByEmail(string $email): ?{$obj->upperCamel()}
    {
        return $this->_get('email', $email);
    }

{foreach from=$tab key=key item=field}
{if $key=='userId'}
    /**
     * get {$mod}
     *
     * @param int $userId
     * @return array
     */
    public function get{$mod->upperCamel()}ByUserId(int $userId): array
    {
        return $this->getMany('user_id', $userId);
    }
{/if}
{/foreach}


    // --------------------------------------------------------------------------------
    //  find UserLogs and get count
    //  多欄、針對性的搜尋, 主要在後台方便使用, 使用 and 搜尋方式
    // --------------------------------------------------------------------------------


}
