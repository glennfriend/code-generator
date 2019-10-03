<?php
namespace App\Entities\Eloquent;

use Illuminate\Database\Eloquent\Model;

/**
 * Class {$obj->upperCamel()}
 *
{foreach from=$tab key=key item=field}
{if $key=='id'}
 * @property int $id
{elseif $field.ado->type=='int'}
 * @property int ${$field.name->lower('_')}
{elseif $field.ado->type=='bigint'}
 * @property bigint ${$field.name->lower('_')}
{elseif $field.ado->type=='smallint'}
 * @property smallint ${$field.name->lower('_')}
{elseif $field.ado->type=='tinyint'}
 * @property tinyint ${$field.name->lower('_')}
{elseif $field.ado->type=='float' || $field.ado->type=='decimal'}
 * @property float ${$field.name->lower('_')}
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
 * @property timestamp ${$field.name->lower('_')}
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
