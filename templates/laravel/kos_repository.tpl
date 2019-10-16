<?php
declare(strict_types=1);
namespace App\Repositories;

use Illuminate\Database\Eloquent\Model;
use Prettus\Repository\Eloquent\BaseRepository;
use App\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};

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

}
