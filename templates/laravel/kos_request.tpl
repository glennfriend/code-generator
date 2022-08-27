<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Requests;
{else        }namespace App\Http\Requests;
{/if}

use Illuminate\Foundation\Http\FormRequest;

class {$obj->upperCamel()}______Request extends FormRequest
{
    public function rules(): array
    {
        return [
            'required_keys'          => 'required|array|min:1',
            'required_keys.*'        => ['required', 'regex:/^(processor_id|card_type|subscription_plan)$/i'],
            'my_status'              => 'exists:enabled,disabled,draft,deleted',
            'my_status'              => Rule::in(['enabled', 'disabled', 'draft', 'deleted']),
            'my_status'              => new \Modules\YourNamespace\Http\Rules\MyRule,
            'my_status'              => 'required|string|min:1',
            'my_status_code'         => 'required|string|size:2',
            'user.age'               => 'nullable|numeric',
            //
{foreach $tab as $key => $field}
{if $key=="id"}
{elseif $key=="properties"}
{elseif $key=="attribs"}
{elseif $key=="createdAt"}
{elseif $key=="deletedAt"}
{elseif $key=="updatedAt"}
{elseif $key=="email"}
            '{$field.ado->name}'{$field.ado->name|space_even}   => 'email',
{elseif $field.ado->type=='timestamp'
        || $field.ado->type=='datetime'
        || $field.ado->type=='date'
}
            '{$field.ado->name}'{$field.ado->name|space_even}   => 'nullable|date',
{elseif $field.ado->type=='tinyint'
        || $field.ado->type=='int'
        || $field.ado->type=='smallint'
        || $field.ado->type=='bigint'
        || $field.ado->type=='float'
        || $field.ado->type=='decimal'
}
            '{$field.ado->name}'{$field.ado->name|space_even}   => 'required|int|min:1',
{else}
            '{$field.ado->name}'{$field.ado->name|space_even}   => 'nullable|string',
{/if}
{/foreach}
        ];
    }

    // TODO: 失敗, 目前無法正確觸發錯誤訊息
    public function messages(): array
    {
        return [
            'required_keys.processor_id.required' => 'status not found',
        ];
    }

    public function authorize(): bool
    {
        return true;
    }

    // --------------------------------------------------------------------------------
    //  other
    // --------------------------------------------------------------------------------

    /**
     * validate page, order, filter
     *      e.g.
     *          ?page=1
     *          &order[]='age:asc'
     *          &order[]='created_at:desc'
     *          &filter[name]='john'
     *          &filter[age]='13:lt
     * 
     * @param Request $request
     */
    public function _other_rules(Request $request)
    {
        $request->validate([
            'page'              => 'nullable|int|min:1',
            'order'             => 'nullable|array',
            'filter'            => 'nullable|array',
            'filter.name'       => 'string',
            'filter.status'     => ["regex:/^(enabled|disabled|draft)$/i"],
            'filter.created_at' => 'date_format:Y-m-d',
        ]);
    }

}