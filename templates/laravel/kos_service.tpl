<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Service;
{else        }namespace App\Service\{$obj->upperCamel()};
{/if}

use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\ModelNotFoundException;
{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Repositories\{$obj->upperCamel()}Repository;
{else}
use App\Entities\{$obj->upperCamel()};
use App\Repositories\{$obj->upperCamel()}Repository;
{/if}

/**
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
    //  write by array
    // --------------------------------------------------------------------------------

    /**
     * @param array $data
     * @return {$obj->upperCamel()}|null
     * @throws Exception
     */
    public function add(array $data): ?{$obj->upperCamel()}
    {
        DB::beginTransaction();

        $data += [
            'started_at' => now(),
            'status'     => null,
        ];
        ${$obj} = $this->{$obj}Repository->create($data);

        ${$obj}->setNumTotal($data['num_total'] ?? null);
        ${$obj}->save();

        DB::commit();
        return ${$obj};
    }


    // --------------------------------------------------------------------------------
    //  write by object
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

        $newObject->save();

        DB::commit();
        return $newObject;
    }

    /**
     * update
     *
     * @param {$obj->upperCamel()} ${$obj}
     */
    public function update({$obj->upperCamel()} ${$obj}): void
    {
        DB::beginTransaction();

        ${$obj}->save();

        DB::commit();
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
        try {
            ${$obj} = $this->get($id);
        }
        catch (ModelNotFoundException $e) {
            return true;
        }
        catch (Exception $e) {
            throw $e;
        }

        DB::beginTransaction();

        $result = $this->delete();

        DB::commit();
        return $result;
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
        }
        catch (ModelNotFoundException $e) {
            return null;
        }
        catch (Exception $e) {
            throw $e;
        }

        return ${$obj};
    }

    /**
     * findByAccountId
     *
     * @param int $accountId
     * @param int $page
     * @return {$obj->upperCamel()}[]|\Traversable
     */
    public function findByAccountId(int $accountId, int $page)
    {
        ${$mod} = $this->{$obj}Repository->find{$mod->upperCamel()}ByAccountId($accountId, $page);
        return ${$mod};
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

}
