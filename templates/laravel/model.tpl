<?php
declare(strict_types = 1);
namespace App\Db;

use Illuminate\Database\Eloquent\Model as EloquentModel;
use App\Db\Base\BaseModel;
use App\Db\Base\ModelExtendCurd;
use App\Db\Eloquent\{$obj->upperCamel()}Emodel;
use App\Db\{$obj->upperCamel()};

/**
 *  {$mod->upperCamel()} model
 */
class {$mod->upperCamel()} extends BaseModel
{
    use ModelExtendCurd;

    protected static $valueObjectName = {$obj->upperCamel()}::class;
    protected static $modelObjectName = {$obj->upperCamel()}Emodel::class;
    protected static $cacheFields     = ['id'];

    /**
     *  map laravel eloquent model to value object
     */
    // protected static function mapValueObject(EloquentModel $model)
    // {
    //     $userLog = parent::mapValueObject($model);
    //     return $userLog;
    // }


    /* ================================================================================
        find UserLogs and get count
        多欄、針對性的搜尋, 主要在後台方便使用, 使用 and 搜尋方式
    ================================================================================ */


    /* ================================================================================
        extends
    ================================================================================ */

    /**
     * get {$mod}
     *
     * @param $userId
     * @return array
     */
    /*
    public static function get{$mod->upperCamel()}ByUserId($userId): array
    {
        return static::getMany('user_id', $userId);
    }
    */

}
