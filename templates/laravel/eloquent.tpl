<?php
declare(strict_types=1);

namespace App\Entities\Eloquent;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Model;

/**
 * Class {$obj->upperCamel()}Eloquent
 *
{foreach from=$tab key=key item=field}
{if $key=='id'}
 * @property int $id
{elseif $field.ado->type|in_array:['tinyint', 'int', 'smallint', 'bigint']}
 * @property int ${$field.name->lower('_')}
{elseif $field.ado->type|in_array:['float', 'decimal']}
 * @property float ${$field.name->lower('_')}
{elseif $field.ado->type|in_array:['timestamp', 'datetime', 'date']}
 * @property \DateTime ${$field.name->lower('_')}
{else}
 * @property string ${$field.name->lower('_')}
{/if}
{/foreach}
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

}
