<?php
declare(strict_types=1);
namespace App\Entities\Eloquent;

use Illuminate\Database\Eloquent\Model;

/**
 * Class {$obj->upperCamel()}
 *
{foreach from=$tab key=key item=field}
{if $key=='id'}
 * @property int $id
{elseif $field.ado->type|in_array:['tinyint', 'int', 'smallint', 'bigint']}
 * @property int ${$field.name->lower('_')}
{elseif $field.ado->type|in_array:['float', 'decimal']}
 * @property float ${$field.name->lower('_')}
{elseif $field.ado->type|in_array:['timestamp', 'datetime', 'date']}
 * @property DateTime ${$field.name->lower('_')}
{else}
 * @property string ${$field.name->lower('_')}
{/if}
{/foreach}
 */
class {$obj->upperCamel()}Eloquent extends Model
{
    protected $table = '{$tableName->lower("_")}';
    public $timestamps = false;

    /*
    protected $fillable = [
{foreach from=$tab key=key item=field}
        '{$field.ado->name}',
{/foreach}
    ];
    */

}
