<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Repositories;
{else        }namespace App\Repositories;
{/if}

use Traversable;
use Illuminate\Database\Eloquent\Model;
use Prettus\Repository\Eloquent\BaseRepository;

{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
{else}
use App\Entities\{$obj->upperCamel()};
{/if}

/**
 * 
 */
class {$obj->upperCamel()}Repository extends BaseRepository
{
    /**
     * Specify Model class name
     *
     * @return string
     */
    function model()
    {
        return {$obj->upperCamel()}::class;
    }

    // --------------------------------------------------------------------------------
    //  chores
    // --------------------------------------------------------------------------------

    /**
     * 
     */
    public function of(array $attributes)
    {
        $model = new {$obj->upperCamel()}();
        $model->fill($attributes);

        return $model;
    }

    // --------------------------------------------------------------------------------
    //  create, update, delete
    // --------------------------------------------------------------------------------

    /**
     * @param array $attributes
     * @return {$obj->upperCamel()}|null
     */
    public function create(array $attributes): ?{$obj->upperCamel()}
    {
        $model = $this->of($attributes);
        $model->created_at = now();
        $model->updated_at = null;

        $model->save();
        return $model;
    }

    /**
     * @param array $attributes
     * @param ${$obj}Id
     * @return mixed|null
     */
    public function update(array $attributes, ${$obj}Id)
    {
        $model = $this->find(${$obj}Id);
        $model->fill($attributes);
        $model->updated_at = now();

        $model->save();
        return $model;
    }

    /**
     * @param ${$obj}Id
     * @return bool
     */
    public function delete(${$obj}Id)
    {
        $model = $this->find(${$obj}Id);

        return $model->delete();
    }

    // --------------------------------------------------------------------------------
    //  read, search
    // --------------------------------------------------------------------------------

    // ${$obj} = $this->find($id);

    /**
     * @param $accountId
     * @return {$obj->upperCamel()}[]
     */
    public function find{$mod->upperCamel()}ByAccountId($accountId): Traversable
    {
        $condition = [
            'account_id' => $accountId,
        ];
        $query = function ($query) {
            return $query->orderBy('id', 'DESC');
        };

        return $this->scopeQuery($query)->findWhere($condition);
    }

}
