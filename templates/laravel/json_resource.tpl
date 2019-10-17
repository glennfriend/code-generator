<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Resources;
{else        }namespace App\Http\Resources;
{/if}

use Illuminate\Http\Resources\Json\JsonResource;

/**
 *
 */
class {$obj->upperCamel()}Resource extends JsonResource
{
    /**
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function toArray($request)
    {
        return [
{foreach from=$tab key=key item=field}
            '{$field.ado->name}' {$field.ado->name|space_even} => $this->{$field.name->lower('_')},
{/foreach}
        ];
    }

}
