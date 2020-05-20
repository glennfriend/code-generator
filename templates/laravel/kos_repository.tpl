<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Repositories;
{else        }namespace App\Repositories;
{/if}

use Traversable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Collection;
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
     * 
     */
    public function __construct({$obj->upperCamel()} ${$obj})
    {
        $this->{$obj} = ${$obj};
    }

    /**
     * get eloquent model
     * 
     * e.g.
     *      $this->{$obj}Repository->model()->firstOrCreate($data);
     * 
     * @return {$obj->upperCamel()}
     */
    function model(): {$obj->upperCamel()}
    {
        return $this->{$obj};
    }

    // --------------------------------------------------------------------------------
    //  chores
    // --------------------------------------------------------------------------------



    // --------------------------------------------------------------------------------
    //  read, search
    // --------------------------------------------------------------------------------

    // ${$obj} = $this->find($id);

    /**
     * @param int $id
     */
    /*
    public function getById(int $id)
    {
        return $this->????->find($id);
        // return $this->->????->where('id', $id)->first();
    }
    */

    public function getById(int $id, string $status)
    {
        // 未測試
        return $this->geoAreaCode
            ->where('id', '=', $id)
            ->where('status', '=', $status)
            ->get();
    }

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

    /**
     * 請修改, 只是 example
     * 
     * @return stdclass array|\Illuminate\Support\Collection
     */
    public function findQueryExample(int $attributeId, string $type, string $sort=null)
    {
        $sort = trim(strtoupper($sort)) === 'DESC' ? 'DESC' : 'ASC';

        $rows = DB::table('geo_attributes_value')
            ->select('geo_attributes_value.*')
            ->leftJoin('geo', 'geo_attributes_value.geo_id', '=', 'geo.id')
            ->where('geo_attributes_value.geo_attr_id', $attributeId)
            ->where('geo.type', $type)
            ->orderByRaw("CAST(geo_attributes_value.value as unsigned) {ldelim}$sort{rdelim}")
            ->get();
        return $rows;
    }

    /**
     * 請修改, 只是 example
     * get 表示取得 elquenet(s)
     * find 表示取得 raw data(s)
     *
     * 取得最近 7 天的 eloquent
     *
     * @param int $day
     * @return ______Eloquent[] array
     */
    public function getQueryExample()
    {
        $day = 7;
        $sql = <<<EOD
            SELECT id
            FROM `your_table_names` 
            WHERE `created_at` > DATE(SUBDATE(NOW(), INTERVAL ? DAY))
            ORDER BY `id` DESC
EOD;

        $rows = [];
        foreach(DB::select($sql, [$day]) as $row) {
            $rows[] = $this->joblog->find($row->id);
        }

        return $rows;
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
