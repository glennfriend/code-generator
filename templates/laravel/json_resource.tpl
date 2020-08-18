<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Resources;
{else        }namespace App\Http\Resources;
{/if}

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 *
 */
class {$obj->upperCamel()}Resource extends JsonResource
{
    /**
     * @var array
     */
    protected static $options = [];

    /**
     * toArray() e.g.
     *      $type = data_get(static::$options, 'type');
     * 
     * controller e.g.
     *      {$obj->upperCamel()}Resource::setOption('your_key', 'your_value');
     * 
     * @param string $key
     * @param $value
     */
    public static function setOption(string $key, $value)
    {
        static::$options[$key] = $value;
    }

    /**
     * @param Request $request
     * @return array
     */
    public function toArray($request)
    {
        return [
{foreach from=$tab key=key item=field}
            '{$field.ado->name}' {$field.ado->name|space_even} => $this->{$field.name->lower('_')},
{/foreach}
            // $this->mergeWhen($this->id >= 0, ['new_attribute' => 'attribute value'])
        ];
    }

}
