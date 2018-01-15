<?php
namespace App\Db\Eloquent;
use Illuminate\Database\Eloquent\Model;

class {$obj->upperCamel()}Emodel extends Model
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
