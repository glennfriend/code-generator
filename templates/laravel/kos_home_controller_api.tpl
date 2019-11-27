<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Controllers;
{else        }namespace App\Http\Controllers;
{/if}

use Exception;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\{ldelim}Request, Response{rdelim};
use Illuminate\Http\Resources\Json\{ldelim}JsonResource, AnonymousResourceCollectionl{rdelim};
use Illuminate\Routing\Controller;
use Illuminate\Database\QueryException;
use Illuminate\Contracts\Routing\ResponseFactory;

{if $isModule}
use Modules\Core\Services\ExceptionError;
{else}
use App\Services\ExceptionError;
{/if}
{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
use Modules\{$obj->upperCamel()}\Http\Resources\{$obj->upperCamel()}Resource;
{else}
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
    -X POST http://127.0.0.1:8000/api/{$mod->lower('-')} \
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
        {$obj->upperCamel()}Service ${$obj}Service)
    {
        $this->{$obj}Service = ${$obj}Service;
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
     * 
     * @apiGroup {$obj->upperCamel()}
     * @apiName list
     * @api {ldelim}get{rdelim} /api/accounts/:accountId/{$mod->lower('-')} list
     * @apiSampleRequest /api/accounts/:accountId/{$mod->lower('-')}
     * @apiParam {ldelim}int{rdelim} accountId
     * 
     * @apiSuccessJson {ldelim}file=../../Tests/Data/Controllers/{$obj->lower('_')}_list_response.json{rdelim} Response: 200 OK
     * @apiSuccessExample Response: 200 OK
     *  {
     *      "data": []
     *      "links": []
     *      "meta": []
     *  }
     * 
     * @param Request $request
     * @param int $accountId
     * @return AnonymousResourceCollection
     */
    public function index(Request $request, int $accountId)
    {
        $page = (int) $request->input('page');
        ${$obj} = $this->{$obj}Service->findByAccountId($accountId, $page);

        $resourceCollection = {$obj->upperCamel()}Resource::collection(${$obj});
        return $resourceCollection;
    }

    /**
     * GET show
     * 
     * @apiGroup {$obj->upperCamel()}
     * @apiName show
     * @api {ldelim}get{rdelim} /api/accounts/:accountId/{$mod->lower('-')}/:{$obj}Id show
     * @apiSampleRequest /api/accounts/:accountId/{$mod->lower('-')}/:{$obj}Id
     * @apiParam {ldelim}int{rdelim} accountId
     * @apiParam {ldelim}int{rdelim} {$obj}Id
     *
     * @apiSuccessJson {ldelim}file=../../Tests/Data/Controllers/{$obj->lower('_')}_show_response.json{rdelim} Response: 200 OK
     * @apiSuccessExample Response: 200 OK
     *  {
     *      "data": {
     *          "id": ""
     *      }
     *  }
     *
     * @param Request $request
     * @param int $accountId
     * @param int ${$obj}Id
     * @return Response|AssetResource
     */
    public function show(Request $request, int $accountId, int ${$obj}Id)
    {
        ${$obj} = $this->{$obj}Service->get(${$obj}Id);
        if (! ${$obj}) {
            $this->error(null, 404);
        }

        list($error, $code) = $this->accountValidate(${$obj}, $accountId));
        if ($error) {
            return $this->error($error, $code);
        }

        $resource = new {$obj->upperCamel()}Resource(${$obj});
        return $resource;
    }

    /**
     * POST create
     * 
     * @apiGroup {$obj->upperCamel()}
     * @apiName store
     * @api {ldelim}post{rdelim} /api/accounts/:accountId/{$mod->lower('-')} store
     * @apiParam {ldelim}int{rdelim} accountId
     *
     * @apiParamJson {ldelim}file=../../Tests/Data/Controllers/{$obj->lower('_')}_store.json{rdelim} Request
     * @apiParamExample Request
     *  {
     *      "data": {
     *          "name": ""
     *      }
     *  }
     * @apiParamExample curl
     *  curl \
     *      -X POST http://127.0.0.1:3000/api/{$mod->lower('-')} \
     *      -H "Content-Type: application/json" \
     *      -d @"Modules/{$obj->upperCamel()}/Tests/Data/Controllers/{$mod->lower('-')}_store.json"
     * @apiSuccessJson {ldelim}file=../../Tests/Data/Controllers/{$obj->lower('_')}_show_response.json{rdelim} Response: 201 Created
     * @apiSuccessExample Response: 201 Created
     *  {
     *      "data": {
     *          "id": ""
     *      }
     *  }
     *
     * @param Request $request
     * @param int $accountId
     * @return ResponseFactory|Response
     * @throws Exception
     */
    public function store(Request $request, int $accountId)
    {
        $payload = $request->input('data');
        $new{$obj->upperCamel()} = new {$obj->upperCamel()}($payload);
        $new{$obj->upperCamel()}->account_id = $accountId;

        list($error, $code) = $this->storeValidate($request, $new{$obj->upperCamel()}, $accountId);
        if ($error) {
            return $this->error($error, $code);
        }

        try {
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

        $resource = new {$obj->upperCamel()}Resource(${$obj})
        return $this->response($resource, 201);
    }

    /**
     * PATCH update
     * 
     * @apiGroup {$obj->upperCamel()}
     * @apiName update
     * @api {ldelim}patch{rdelim} /api/accounts/:accountId/{$mod->lower('-')}/{$obj}Id update
     * @apiParam {ldelim}int{rdelim} accountId
     * @apiParam {ldelim}int{rdelim} {$obj}Id
     *
     * @apiParamExample Request
     *  like "store"
     * @apiSuccessExample Response: 201
     *  like "store"
     * 
     * @param Request $request
     * @param int $accountId
     * @param int ${$obj}Id
     * @return ResponseFactory|Response|AssetController
     * @throws Exception
     */
    public function update(Request $request, int $accountId, int ${$obj}Id)
    {
        ${$obj} = $this->{$obj}Service->get(${$obj}Id);
        if (! ${$obj}) {
            return $this->error(null, 404);
        }

        $payload = $request->input('data');
        ${$obj}->fill($payload);

        list($error, $code) = $this->storeValidate($request, $asset, $accountId);
        if ($error) {
            return $this->error($error, $code);
        }

        try {
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

        $resource = new {$obj->upperCamel()}Resource(${$obj})
        return $this->response($resource, 201);
    }

    /**
     * DELETE delete
     *
     * @apiGroup {$obj->upperCamel()}
     * @apiName delete
     * @api {ldelim}delete{rdelim} /api/accounts/:accountId/{$mod->lower('-')}/{$obj}Id delete
     * @apiParam {ldelim}int{rdelim} accountId
     * @apiParam {ldelim}int{rdelim} {$obj}Id
     *
     * @apiSuccessExample Response: 204 Not Content
     *  null
     * 
     * @param Request $request
     * @param int $accountId
     * @param int ${$obj}Id
     * @return ResponseFactory|Response
     */
    public function destroy(Request $request, int $accountId, int ${$obj}Id)
    {
        ${$obj} = $this->{$obj}Service->get(${$obj}Id);
        if (! ${$obj}) {
            return response(null, 204);
        }

        list($error, $code) = $this->accountValidate(${$obj}, $accountId);
        if ($error) {
            return $this->error($error, $code);
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
     * @param {$obj->upperCamel()} ${$obj}
     * @param int $accountId
     * @return array
     */
    protected function storeValidate(Request $request, int $accountId): array
    {
        $validator = Validator::make($request->input('data'), [
            'required_keys'          => 'required|array|min:1',
            'required_keys.*'        => ['required', 'regex:/^(processor_id|card_type|subscription_plan)$/i'],
            'my_status'              => 'exists:enabled,disabled,draft,deleted',
        ]);

        $validator = Validator::make($request->input('data'), [
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

        $validator->after(function ($validator) use ($request, $accountId) {
            if ($accountId !== $request->input('data.account_id')) {
                $validator->errors()->add('account_id', 'account_id error');
            }
        });
        */

        if ($validator->fails()) {
            return [$validator->errors()->first(), 400];
        }

        list($error, $code) = $this->accountValidate(${$obj}, $accountId));
        if ($error) {
            return [$error, $code];
        }
        
        return [null, null];
    }

    /**
     * @param {$obj->upperCamel()} ${$obj}
     * @param int $accountId
     * @return array
     */
    protected function accountValidate({$obj->upperCamel()} ${$obj}, int $accountId): array
    {
        if ((int) ${$obj}->account_id !== $accountId) {
            return ['account error', 404];
        }

        return [null, null];
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
            Log::error('[{$obj->upperCamel()}Controller]: handle error', [
                'error' => $exception->getMessage(),
            ]);
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

    /**
     * laravel response() 無法同時處理 JsonResource and return http status code
     *
     * @param JsonResource|array|null $resource
     * @param int $code
     * @return $this|Response|ResponseFactory
     */
    protected function response($resource = null, $code = 200)
    {
        if ($resource instanceof JsonResource) {
            return $resource->response()->setStatusCode($code);
        }
        else {
            return response($resource, $code);
        }
    }

}
