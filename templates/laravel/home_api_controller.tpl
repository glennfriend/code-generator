<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Controllers;
{else        }namespace App\Http\Controllers;
{/if}

use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$mod->upperCamel()};
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
use Modules\{$obj->upperCamel()}\Http\Resources\{$obj->upperCamel()}Resource;
{else}
use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};
use App\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
use App\Http\Resources\{$obj->upperCamel()}Resource;
{/if}


/*
$config = [
    'as' => '{$mod->lower('-')}',
    'middleware' => ['api'],
];
Route::group($config, function () {
    Route::get   ('/{$mod->lower('-')}',  {$obj->lowerCamel()|strlen|repeat}     '{$obj->upperCamel()}Controller@index');
    Route::get   ('/{$mod->lower('-')}/{ldelim}{$obj->lowerCamel()}Id{rdelim}',  '{$obj->upperCamel()}Controller@show');
    Route::post  ('/{$mod->lower('-')}',  {$obj->lowerCamel()|strlen|repeat}     '{$obj->upperCamel()}Controller@store');
    Route::patch ('/{$mod->lower('-')}/{ldelim}{$obj->lowerCamel()}Id{rdelim}',  '{$obj->upperCamel()}Controller@update');
    Route::delete('/{$mod->lower('-')}/{ldelim}{$obj->lowerCamel()}Id{rdelim}',  '{$obj->upperCamel()}Controller@destroy');
});

curl -X GET    http://127.0.0.1:8000/api/{$mod->lower('-')}         && echo
curl -X GET    http://127.0.0.1:8000/api/{$mod->lower('-')}/100     && echo
curl -X POST   http://127.0.0.1:8000/api/{$mod->lower('-')}         && echo
curl -X PATCH  http://127.0.0.1:8000/api/{$mod->lower('-')}/100     && echo
curl -X DELETE http://127.0.0.1:8000/api/{$mod->lower('-')}/100     && echo
*/

/**
 *
 */
class {$obj->upperCamel()}ApiController extends Controller
{
    /**
     *
     */
    public function __construct(
        {$mod->upperCamel()} ${$mod}
    )
    {
        $this->{$mod} = ${$mod};
    }

    /**
     * GET list
     */
    public function index(Request $request)
    {
        return 'index ';

        /*
        $objects = $this->{$obj}Repository->find{$mod->upperCamel()}ByAccountId($accountId);
        $response = [
            'data' => {$obj->upperCamel()}Resource::collection($objects),
        ];

        return response($response, 200);
        */
    }

    /**
     * GET show
     */
    public function show(Request $request, $id)
    {
        return 'show ' . $id;
    }

    /**
     * POST create
     */
    public function store(Request $request)
    {
        return 'store ';
    }

    /**
     * PATCH update
     */
    public function update(Request $request, $id)
    {
        return 'update ' . $id;
    }

    /**
     * DELETE delete
     */
    public function destroy($id)
    {
        return 'distory ' . $id;
    }

    // --------------------------------------------------------------------------------
    //  other
    // --------------------------------------------------------------------------------

    /**
     * GET
     *      - input validate example
     */
    public function get_specific_content(Request $request)
    {
        $validator = Validator::make($request->query(), [
            'required_keys'          => 'required|array|min:1',
            'required_keys.*'        => ['required', 'regex:/^(processor_id|card_type|subscription_plan)$/i'],
            'my_status'              => 'exists:enabled,disabled,draft,deleted',
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
        ]);

        /*
        $validator->after(function ($validator) {
            if ($this->somethingElseIsInvalid()) {
                $validator->errors()->add('field', 'Something is wrong with this field!');
            }
        });
        */

        if ($validator->fails()) {
            $body = [
                'message' => $validator->errors()->first()
            ];
            return response()->json($body, 400);
        }

        $body = [
            'data' => [
{foreach $tab as $key => $field}
{if $key=="id"}
{elseif $key=="properties"}
{elseif $key=="attribs"}
{elseif $key=="createdAt"}
{elseif $key=="deletedAt"}
{elseif $key=="updatedAt"}
{elseif $key=="email"}
                '{$field.ado->name}'{$field.ado->name|space_even}   => $request->get('email'),
{elseif $field.ado->type=='timestamp'
     || $field.ado->type=='datetime'
     || $field.ado->type=='date'
}
                '{$field.ado->name}'{$field.ado->name|space_even}   => $request->get('{$field.ado->name}'),
{elseif $field.ado->type=='tinyint'
     || $field.ado->type=='int'
     || $field.ado->type=='smallint'
     || $field.ado->type=='bigint'
     || $field.ado->type=='float'
     || $field.ado->type=='decimal'
}
                '{$field.ado->name}'{$field.ado->name|space_even}   => (int) $request->get('{$field.ado->name}'),
{else}
                '{$field.ado->name}'{$field.ado->name|space_even}   => $request->get('{$field.ado->name}'),
{/if}
{/foreach}
            ],
        ]
        return response()->json($body);
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------


}
