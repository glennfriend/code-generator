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
use Illuminate\Database\QueryException;

{if $isModule}
use Modules\Core\Services\ExceptionError;
{else}
use App\Services\ExceptionError;
{/if}
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

curl \
    -X POST   http://127.0.0.1:8000/api/{$mod->lower('-')} \
    -H "Content-Type: application/json" \
    -d @"Modules/{$obj->upperCamel()}/Tests/Data/Controllers/{$obj->lower('_')}_store.json"
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

    // --------------------------------------------------------------------------------
    //  basic
    // --------------------------------------------------------------------------------

    /**
     * GET list
     */
    public function index(Request $request)
    {
        return 'index ';
    }

    /**
     * GET show
     */
    public function show(Request $request, int ${$obj}Id)
    {
        return 'show ' . ${$obj}Id;
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
    public function update(Request $request, int ${$obj}Id)
    {
        return 'update ' . ${$obj}Id;
    }

    /**
     * DELETE delete
     */
    public function destroy(Request $request, int ${$obj}Id)
    {
        return 'distory ' . ${$obj}Id;
    }

    // --------------------------------------------------------------------------------
    //  basic for account_id
    // --------------------------------------------------------------------------------

    /**
     * GET list
     */
    public function index(Request $request, int $accountId)
    {
        $page = (int) $request->input('page');
        ${$mod} = $this->{$obj}Service->findByAccountId($accountId, $page);

        $response = {$obj->upperCamel()}Resource::collection(${$mod});
        return $response;
    }

    /**
     * GET show
     */
    public function show(Request $request, int $accountId, int ${$obj}Id)
    {
        ${$obj} = $this->{$obj}Service->get(${$obj}Id);
        if (! ${$obj}) {
            $this->error(null, 404);
        }
        if ($error = $this->accountValidate(${$obj}, $accountId)) {
            return $this->error($error, 404);
        }

        $response = new {$obj->upperCamel()}Resource(${$obj});
        return $response;
    }

    /**
     * POST create
     */
    public function store(Request $request, int $accountId)
    {
        if ($error = $this->storeValidate($request, $accountId)) {
            return $this->error($error, 400);
        }

        try {
            $payload = $request->input('{$obj->lower('_')}');
            $new{$mod} = new {$mod}($payload);
            ${$obj} = $this->{$obj}Service->add($new{$mod});
        }
        catch (QueryException $e) {
            if (ExceptionError::isForeignKeyConstraint($e)) {
                $error = 'foreign key constraint error';
            }
            else {
                $error = 'query error';
            }
            return $this->error($error, 400, $e);
        }
        catch (Exception $e) {
            throw $e;
        }

        $response = new {$obj->upperCamel()}Resource(${$obj});
        return response($response, 201);
    }

    /**
     * PATCH update
     */
    public function update(Request $request, int $accountId, int ${$obj}Id)
    {
        if ($error = $this->storeValidate($request, $accountId)) {
            return $this->error($error, 400);
        }

        ${$obj} = $this->{$obj}Service->get(${$obj}Id);
        if (! ${$obj}) {
            return $this->error(null, 404);
        }
        if ($error = $this->accountValidate(${$obj}, $accountId)) {
            return $this->error($error, 404);
        }

        try {
            $payload = $request->input('{$obj->lower('_')}');
            ${$obj}->fill($payload);
            $this->{$obj}Service->update(${$obj});
        }
        catch (QueryException $e) {
            $error = 'query error';
            if (ExceptionError::isForeignKeyConstraint($e)) {
                $error = 'foreign key constraint error';
            }
            return $this->error($error, 404, $e);
        }
        catch (Exception $e) {
            throw $e;
        }

        $response = new {$obj->upperCamel()}Resource(${$obj});
        return response($response, 201);
    }

    /**
     * DELETE delete
     */
    public function destroy(Request $request, int $accountId, int ${$obj}Id)
    {
        ${$obj} = $this->{$obj}Service->get(${$obj}Id);
        if (! ${$obj}) {
            return response(null, 204);
        }
        if ($error = $this->accountValidate(${$obj}, $accountId)) {
            return $this->error($error, 404);
        }

        $this->{$obj}Service->delete(${$obj}Id);
        return response(null, 204);
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------



    // --------------------------------------------------------------------------------
    //  other
    // --------------------------------------------------------------------------------

    /**
     * @param Request $request
     * @param int $accountId
     * @return null|string
     */
    protected function storeValidate(Request $request, int $accountId): ?string
    {
        $validator = Validator::make($request->all(), [
            'required_keys'          => 'required|array|min:1',
            'required_keys.*'        => ['required', 'regex:/^(processor_id|card_type|subscription_plan)$/i'],
            'my_status'              => 'exists:enabled,disabled,draft,deleted',
        ]);

        $validator = Validator::make($request->all(), [
{foreach $tab as $key => $field}
{if $key=="id"}
{elseif $key=="properties"}
{elseif $key=="attribs"}
{elseif $key=="createdAt"}
{elseif $key=="deletedAt"}
{elseif $key=="updatedAt"}
{elseif $key=="email"}
            '{$obj->lower('_')}.{$field.ado->name}'{$field.ado->name|space_even}   => 'email',
{elseif $field.ado->type=='timestamp'
     || $field.ado->type=='datetime'
     || $field.ado->type=='date'
}
            '{$obj->lower('_')}.{$field.ado->name}'{$field.ado->name|space_even}   => 'nullable|date',
{elseif $field.ado->type=='tinyint'
     || $field.ado->type=='int'
     || $field.ado->type=='smallint'
     || $field.ado->type=='bigint'
     || $field.ado->type=='float'
     || $field.ado->type=='decimal'
}
            '{$obj->lower('_')}.{$field.ado->name}'{$field.ado->name|space_even}   => 'required|int|min:1',
{else}
            '{$obj->lower('_')}.{$field.ado->name}'{$field.ado->name|space_even}   => 'nullable|string',
{/if}
{/foreach}
        ]);

        $validator->after(function ($validator) use ($request, $accountId) {
            if ($accountId !== $request->input('{$obj->lower('_')}.account_id')) {
                $validator->errors()->add('account_id', 'account_id error');
            }
        });

        /*
        $validator->after(function ($validator) {
            if ($this->somethingElseIsInvalid()) {
                $validator->errors()->add('field', 'Something is wrong with this field!');
            }
        });

        $validator->after(function ($validator) use ($request, $accountId) {
            if ($accountId !== $request->input('{$obj->lower('_')}.account_id')) {
                $validator->errors()->add('account_id', 'account_id error');
            }
        });
        */

        if ($validator->fails()) {
            return (string) $validator->errors()->first();
        }
        return null;
    }

    /**
     * @param {$obj->upperCamel()} ${$obj}
     * @param int $accountId
     * @return null|string
     */
    protected function accountValidate({$obj->upperCamel()} ${$obj}, int $accountId): ?string
    {
        if ((int) ${$obj}->account_id !== $accountId) {
            return 'account error';
        }

        return null;
    }

    /**
     * @param string|null $message
     * @param int $code
     * @param Exception|null $exception
     * @return Response
     */
    protected function error($message = null, int $code = 400, Exception $exception = null): Response
    {
        if ($exception instanceof Exception) {
            Log::error($exception->getMessage());
        }

        if ($message) {
            $body = [
                'message' => $message,
            ];
        }
        else {
            $body = [];
        }

        return response($body, $code);
    }

    // 不使用, 請請用 JsonResource
    protected function get_resource()
    {
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

}
