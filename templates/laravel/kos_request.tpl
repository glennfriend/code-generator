<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Requests;
{else        }namespace App\Http\Requests;
{/if}

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Validation\Validator;
use Symfony\Component\HttpFoundation\Response;

class {$obj->upperCamel()}______Request extends FormRequest
{
    public function rules(): array
    {
        return [
            'required_keys'          => 'required|array|min:1',
            'required_keys.*'        => ['required', 'regex:/^(processor_id|card_type|subscription_plan)$/i'],
            'required_keys.*.id'     => 'required',
            'my_status'              => 'exists:enabled,disabled,draft,deleted',
            'my_status'              => Rule::in(['enabled', 'disabled', 'draft', 'deleted']),
            'my_status'              => new \Modules\YourNamespace\Http\Rules\MyRule,
            'my_status'              => ['required', 'string' new MyRule()],
            'my_status'              => 'required|string|min:1',
            'my_status_code'         => 'required|string|size:2',
            'user.age'               => 'nullable|numeric',
            'email_1'                => 'email|required_without:email_2',     // email_1, email_2 其中一個必填, 
            'email_2'                => 'email|required_without:email_1',     // 最前面的 email 指的是 email validate
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

    /**
     * 對應 rules() 的錯誤訊息
     */
    public function attributes(): array
    {
        return [
            'required_keys.*.id' => '[id]',
        ];
    }

    /*
    // TODO: 失敗, 目前無法正確觸發錯誤訊息
    public function messages(): array
    {
        return [
            'required_keys.processor_id.required' => 'status not found',
        ];
    }
    */

    public function authorize(): bool
    {
        return true;
    }

    protected function failedValidation(\Illuminate\Contracts\Validation\Validator $validator): void
    {
        throw new HttpResponseException(response()->json([
            'message' => $validator->errors()->first(),
        ], Response::HTTP_UNPROCESSABLE_ENTITY));
    }

    public function withValidator(Validator $validator): void
    {
        if ($validator->getMessageBag()->messages()) {
            // messages exists, 前面的驗証已失敗
            return;
        }

        // 繼續驗證細節
        $validator->after(function (Validator $validator) {
            $this->emailAndPhoneNumberValidator($validator);
        });
    }

    protected function emailAndPhoneNumberValidator(Validator $validator): void
    {
        $input = $validator->getData();
        foreach ($input['data'] as $row) {
            if (!isset($row['email']) && !isset($row['phoneNumber'])) {
                $validator->errors()->add('email', 'Must have at least one parameter: email|phoneNumber');
            }
        }
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
    public function _other_rules(Request $request): void
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