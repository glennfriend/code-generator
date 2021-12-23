<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Entities;
{else        }namespace App\Entities;
{/if}

use DateTime
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Carbon;

/**
 * Class {$obj->upperCamel()}Eloquent
 * 該 Entity 的用途為何 ??
 *
{foreach from=$tab key=key item=field}
{if $key=='id'}
 * @property int $id
{elseif $field.ado->type|in_array:['tinyint', 'int', 'smallint', 'bigint']}
 * @property int ${$field.name->lower('_')}
{elseif $field.ado->type|in_array:['float', 'decimal']}
 * @property float ${$field.name->lower('_')}
{elseif $field.ado->type|in_array:['timestamp', 'datetime', 'date']}
 * @property DateTime|Carbon|null ${$field.name->lower('_')}
{else}
 * @property string ${$field.name->lower('_')}
{/if}
{/foreach}
 * @mixin Builder
 */
class {$obj->upperCamel()}Eloquent extends Model
{
    // use SoftDeletes;

    protected $table = '{$tableName->lower("_")}';
    public $timestamps = false;

    /**
     * 批量賦值 的 白名單
     */
    protected $fillable = [
{foreach from=$tab key=key item=field}
{if in_array($key, ['id', 'password', 'is_admin', 'updated_at', 'deleted_at'])}
{else}
        '{$field.ado->name}',
{/if}
{/foreach}
    ];

{foreach from=$tab key=key item=field}
{if $key=='status'}
    // --------------------------------------------------------------------------------
    //  status extend
    // --------------------------------------------------------------------------------

    const STATUS_ENABLED = 'enabled';
    const STATUS_DISABLED = 'disabled';

    /**
     * e.g.
        if (! in_array($status, {$obj->upperCamel()}Eloquent::useStatusList())) {
            return false;
        }
     */
    public static function useStatusList(): array
    {
        return ['available', 'used'];
    }
{else}
{/if}
{/foreach}

    // --------------------------------------------------------------------------------
    //  rewrite origin method
    // --------------------------------------------------------------------------------
    /*
    public function setPhoneNumberAttribute(string $phoneNumber)
    {
        $this->attributes['phone_number'] = strtolower(trim($phoneNumber));

        if ($areCode = $this->guessAreaCode($phoneNumber)) {
            $this->attributes['area_code'] = $areCode;
        }
    }
    */

    // --------------------------------------------------------------------------------
    //  parent/反相關連/one-to-one association
    // --------------------------------------------------------------------------------
    public function parent(): BelongsTo
    {
        return $this->belongsTo(ParentEloquent::class, 'parent_id', $localKey = 'id');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(UserEloquent::class, 'user_id', $localKey = 'id');
    }

    // --------------------------------------------------------------------------------
    //  以自己 (1) {$obj->upperCamel()}::class 為主要
    //  1 對 多
    // --------------------------------------------------------------------------------
    public function children()
    {
        return $this->hasMany(ChildEloquent::class, 'parent_id', $localKey = 'id');
    }

    // --------------------------------------------------------------------------------
    //  1 對 多
    // --------------------------------------------------------------------------------
    /**
     * get user of blogs
     */
    public function blogs(string $status = 'enabled')
    {
        return $this
            ->hasMany(Blogs::class, 'user_id', 'id')
            ->where('status', $status);
    }

    // --------------------------------------------------------------------------------
    //  extend
    // --------------------------------------------------------------------------------

    public function getNumTotal(): ?int
    {
        return $this->getCustom('mapping.num_total');
    }

    public function setNumTotal(int $value=null)
    {
        $this->setCustom('mapping.num_total', $value);
    }

}
