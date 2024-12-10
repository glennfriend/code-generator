<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Entities;
{else        }namespace App\Entities;
{/if}

use Carbon\Carbon;
use DateTime;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

{if $isModule}
use Modules\{$obj->upperCamel()}\Database\Factories\{$obj->upperCamel()}Factory;
{else}
use App\Database\Factories\{$obj->upperCamel()}Factory;
{/if}

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
{elseif $field.ado->type|in_array:['json']}
 * @property array ${$field.name->lower('_')}
{elseif $field.ado->type|str_contains:'unsigned'}
 * @property int ${$field.name->lower('_')}
{elseif $field.ado->type|in_array:['timestamp', 'datetime', 'date']}
 * @property Carbon ${$field.name->lower('_')}
{else}
 * @property string ${$field.name->lower('_')}  ({$field.ado->type})
{/if}
{/foreach}
 * @method {$obj->upperCamel()}Factory factory()
 * @mixin Builder
 *
 * @property-read Account $account      // 如果你有 account_id 並且有做 BelongsTo 的關連表
 */
class {$obj->upperCamel()}Eloquent extends Model
{
    use HasFactory;
    // use SoftDeletes;

    protected $table = '{$tableName->lower("_")}';
    public $timestamps = false;

    protected array $hidden = ['password', 'properties'];

    /**
     * 批量賦值 的 黑名單
     * 適用於大部份資料可以任意寫入 e.g. 內部資料, Report, Log
     * 
     * @var string[]
     */
    protected $guarded = ['id'];

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

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        // 'custom' => CustomCastor::class,
        // 'custom' => 'array',
        // 'birthday' => 'date:Y-m-d',
        // 'target_at' => 'timestamp',
    ];

    // laravel 8 database factory
    public static function newFactory(): Factory    // {$obj->upperCamel()}Factory
    {
        return {$obj->upperCamel()}Factory::new();
    }


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
    //  向上關連/反相關連/parent/one-to-one association
    // --------------------------------------------------------------------------------
    public function parent(): BelongsTo
    {
        return $this->belongsTo(ParentEloquent::class, 'parent_id', $localKey = 'id');
    }

    /**
     * 你可以加到 class 的 PHPDoc ---> @property-read User $user
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(UserEloquent::class, 'user_id', $localKey = 'id');
    }

    // --------------------------------------------------------------------------------
    //  以自己 (1) {$obj->upperCamel()}::class 為主要
    //  1 對 多
    // --------------------------------------------------------------------------------
    public function children(): HasMany
    {
        return $this->hasMany(ChildEloquent::class, 'parent_id', $localKey = 'id');
    }

    // --------------------------------------------------------------------------------
    //  1 對 多
    // --------------------------------------------------------------------------------
    /**
     * get user of blogs
     */
    public function blogs(string $status = 'enabled'): HasMany
    {
        return $this
            ->hasMany(Blogs::class, 'user_id', 'id')
            ->where('status', $status);
    }

    // --------------------------------------------------------------------------------
    //  多 對 多
    // --------------------------------------------------------------------------------
    /**
     * 該 model 對應到多個 account
     */
    public function accounts(): BelongsToMany
    {
        return $this->belongsToMany(
            related: Account::class,
            table: 'mymodels_accounts',     // 用來建立 多對多 的 table, 你自己要建立
            foreignPivotKey: 'model_id',    // 多對多 table 裡面, 你的 id
            relatedPivotKey: 'account_id',  // 多對多 table 裡面, account (目標 table) 的 id
        );
    }

    // --------------------------------------------------------------------------------
    //  關連表 ?? 未測試成功
    // --------------------------------------------------------------------------------
    /*
        $this->hello_world 關連到 HelloWorld entity,

        // HelloWorld entity 要建立
        public function verifiable(): MorphTo
        {
            return $this->morphTo();
        }

        // 產生的 SQL
        SELECT  *
        FROM    `現在這張表`
        WHERE   `現在這張表`.`verifiable_id` = 27
        AND     `現在這張表`.`verifiable_id` IS NOT NULL
        AND     `現在這張表`.`verifiable_type` = "contact"
        AND     `現在這張表`.`type` = "phone"   // 這裡沒有成功 ?
        ORDER BY `id` DESC 
        LIMIT 1
     */
    public function getHelloWorldAttribute(): ?PhoneVerification
    {
        return $this->morphMany(PhoneVerification::class, 'verifiable')
            ->orderBy('id', 'desc')
            ->first();
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
