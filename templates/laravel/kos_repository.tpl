<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Repositories;
{else        }namespace App\Repositories;
{/if}

use Traversable;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Cache;
use Illuminate\Pagination\Paginator;
use Illuminate\Database\Eloquent\Model;
use Prettus\Repository\Eloquent\BaseRepository;
// use Modules\Core\Repositories\ExtendedRepository;
// use Modules\Core\Traits\CacheKey;

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
    // use CacheKey;

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
     * @param int $accountId
     * @param int $page
     * @return {$obj->upperCamel()}[]
     */
    public function find{$mod->upperCamel()}ByAccountId(int $accountId, int $page = 1): Traversable
    {
        $page = ($page > 1 ? $page : 1);
        Paginator::currentPageResolver(function () use ($page) {
            return $page;
        });

        $builder = {$obj->upperCamel()}::where('account_id', $accountId)
            ->orderBy('id', 'DESC');

        /*
        $filterByName = data_get($filter, 'name');
        if ($filterByName) {
            $builder = $builder->where('name', 'like', "%{ldelim}$filterByName{rdelim}%");
        }
        */

        /*
        $condition = [
            'account_id' => $accountId,
        ];
        $query = function ($query) {
            return $query->orderBy('id', 'DESC');
        };

        return $this->scopeQuery($query)->findWhere($condition);
        */

        return $builder->paginate();
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     * get cache data
     *      - for laravel cache
     *      - life time is second
     *      - allow force update cache
     *
     * dependency
     *      - Illuminate\Support\Facades\Cache
     *      - Illuminate\Support\Collection
     *      - Modules\Core\Traits\CacheKey
     *
     * Closure example
     *      $fetch = function () use ($from, $to) {
     *          return DB::table('users')
     *              ->select('name')
     *              ->whereBetween('created_at', [$from, $to])
     *              ->distinct()
     *              ->get()
     *              ->pluck('name');
     *      };
     *
     * NOTE: 改用 trait CacheData
     * 
     * @param Closure $func
     * @param array $params
     * @param int $lifetime
     * @param bool $forceUpdateCache
     * @return Collection
     */
    protected function readCache(Closure $func, array $params=[], int $lifetime, $forceUpdateCache=false): Collection
    {
        $cacheKey = $this->generateCacheKey($params);

        if ($forceUpdateCache) {
            $collection = $func();
            Cache::put($cacheKey, $collection, $lifetime);
        }

        if ($collection = Cache::get($cacheKey)) {
            // cache hit
            return $collection;
        }

        $collection = $func();
        Cache::put($cacheKey, $collection, $lifetime);

        return $collection;
    }

}
