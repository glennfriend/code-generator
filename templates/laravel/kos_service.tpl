<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Service;
{else        }namespace App\Service\{$obj->upperCamel()};
{/if}

use Exception;
use DB;
use Log;

{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Repositories\{$obj->upperCamel()}Repository;
{else}
use App\Entities\{$obj->upperCamel()};
use App\Repositories\{$obj->upperCamel()}Repository;
{/if}

/**
 * {$obj->upperCamel()} Service
 *
 */
class {$obj->upperCamel()}Service
{

    public function __construct(
        {$obj->upperCamel()}Repository ${$obj}Repository
    )
    {
        $this->{$obj}Repository = ${$obj}Repository;
    }

    // --------------------------------------------------------------------------------
    //  write
    // --------------------------------------------------------------------------------

    /**
     * add
     *
     * @param {$obj->upperCamel()} $newObject
     * @return {$obj->upperCamel()}|null
     * @throws Exception
     */
    public function add({$obj->upperCamel()} $newObject): ?{$obj->upperCamel()}
    {
        DB::beginTransaction();

        try {
            $newObject->save();
        }
        catch (Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }

        DB::commit();
        return $newObject;
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
        DB::beginTransaction();

        try {
            ${$obj}->svae();
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
     * @throws Exception
     */
    public function delete($id): bool
    {
        ${$obj} = $this->get($id);
        if (! ${$obj}) {
            return true;
        }

        DB::beginTransaction();

        try {
            $this->delete();
        }
        catch (Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }

        DB::commit();
        return true;
    }

    // --------------------------------------------------------------------------------
    //  read
    // --------------------------------------------------------------------------------

    /**
     * get
     *
     * @param int ${$obj->lowerCamel()}Id
     * @return {$obj->upperCamel()}|null
     * @throws Exception
     */
    public function get(int $id): ?{$obj->upperCamel()}
    {
        try {
            ${$obj} = $this->{$obj}Repository->find($id);
            if (! ${$obj}) {
                return null;
            }
        }
        catch (Exception $e) {
            throw new Exception($e->getMessage());
        }

        return ${$obj};
    }

    /**
     * findByAccountId
     *
     * @param int $accountId
     * @return {$obj->upperCamel()}[]|\Traversable
     * @throws Exception
     */
    public function findByAccountId(int $accountId)
    {
        try {
            ${$mod} = $this->{$obj}Repository->find{$mod->upperCamel()}ByAccountId($accountId);
            
        }
        catch (Exception $e) {
            throw new Exception($e->getMessage());
        }

        return ${$mod};
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

}
