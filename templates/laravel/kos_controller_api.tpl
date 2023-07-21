<?php

declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Api\Controllers;
{else        }namespace App\Http\Api\Controllers;
{/if}

use Exception;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\{ldelim}Request, Response{rdelim};
use Illuminate\Http\Resources\Json\{ldelim}JsonResource, AnonymousResourceCollectionl{rdelim};
use Illuminate\Routing\Controller;
use Illuminate\Database\QueryException;
use Illuminate\Contracts\Routing\ResponseFactory;
use Symfony\Component\HttpFoundation\Response;

{if $isModule}
use Modules\Core\Services\ExceptionError;
{else}
use App\Services\ExceptionError;
{/if}
{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Http\Resources\{$obj->upperCamel()}Resource;
use Modules\{$obj->upperCamel()}\Repositories\{$obj->upperCamel()}Repository;
use Modules\{$obj->upperCamel()}\Services\{$obj->upperCamel()}Service;
use Modules\{$obj->upperCamel()}\Http\Resources\{$obj->upperCamel()}Resource;
{else}
use App\Entities\{$obj->upperCamel()};
use App\Http\Resources\{$obj->upperCamel()}Resource;
use App\Repositories\{$obj->upperCamel()}Repository;
use App\Services\{$obj->upperCamel()}Service;
use App\Http\Resources\{$obj->upperCamel()}Resource;
{/if}

/*
use Illuminate\Support\Facades\Route;


// API reoute
$config = [
    // 'prefix' => 'accounts/{ldelim}accountId{rdelim}'
    // 'prefix' => '{$mod->lower('-')}/{ldelim}{$obj->lower('-')}Id{rdelim}',
       'prefix' => '{$mod->lower('-')}',
       'as' => '{$mod->lower('-')}',
       'middleware' => ['api'],
    // 'middleware' => ['auth:api'],
];
Route::group($config, function () {
    Route::get   ('/{$mod->lower('-')}',  {$obj->lowerCamel()|strlen|repeat}     'Api\\{$obj->upperCamel()}Controller@index');
    Route::get   ('/{$mod->lower('-')}/{ldelim}{$obj->lowerCamel()}Id{rdelim}',  'Api\\{$obj->upperCamel()}Controller@show');
    Route::post  ('/{$mod->lower('-')}',  {$obj->lowerCamel()|strlen|repeat}     'Api\\{$obj->upperCamel()}Controller@store');
    Route::patch ('/{$mod->lower('-')}/{ldelim}{$obj->lowerCamel()}Id{rdelim}',  'Api\\{$obj->upperCamel()}Controller@update');
    Route::delete('/{$mod->lower('-')}/{ldelim}{$obj->lowerCamel()}Id{rdelim}',  'Api\\{$obj->upperCamel()}Controller@destroy');
    // or
    Route::resource('{$mod->lower('-')}', '{$obj->upperCamel()}Controller');
    Route::apiResource('{$mod->lower('-')}', '{$obj->upperCamel()}Controller');
    // or
    Route::resource('/{$mod->lower('-')}', '{$obj->upperCamel()}Controller', [
        'only' => ['index', 'show', 'store', 'update', 'destroy'],
        'names' => '{$obj->lower('-')}',
    ]);
    //
    Route::resource('/accounts/{ldelim}accountId{rdelim}/{$mod->lower('-')}', '{$obj->upperCamel()}Controller', [
        'only' => ['index', 'show', 'store'],
        'names' => [
            'index' => '{$mod->lower('-')}.index',
            'store' => '{$mod->lower('-')}.store',
        ],
    ]);
    // laravel 8.80
    Route::controller(YourController::class)->group(function(){
        Route::get('users', 'index');
        Route::get('users', 'store');
        Route::get('users/{ldelim}userId{rdelim}', 'show');
    })

});
*/


/*
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
        private readonly {$obj->upperCamel()} ${$obj},
        private readonly {$obj->upperCamel()}Repository ${$obj}Repository,
        private readonly {$obj->upperCamel()}Service ${$obj}Service
    )
    {
        $this->{$obj} = ${$obj};
        $this->{$obj}Repository = ${$obj}Repository;
        $this->{$obj}Service = ${$obj}Service;
    }

    // --------------------------------------------------------------------------------
    //  basic
    // --------------------------------------------------------------------------------

    public function index(Request $request)
    {
        return '[GET] list ';
    }
    public function show(Request $request, int ${$obj}Id)
    {
        return '[GET] show ' . ${$obj}Id;
    }
    public function store(Request $request)
    {
        return '[POST] create ';
    }
    public function update(Request $request, int ${$obj}Id)
    {
        return '[PATCH] update ' . ${$obj}Id;
    }
    public function destroy(Request $request, int ${$obj}Id)
    {
        return '[DELETE] delete ' . ${$obj}Id;
    }

    // --------------------------------------------------------------------------------
    //  basic for account_id
    // --------------------------------------------------------------------------------

    /**
     * GET list
     * 
     * @param Request $request
     * @param int $accountId
     * @return AnonymousResourceCollection
     */
    public function index(Request $request, int $accountId)
    {
        /*
        if ($response = $this->customValidate($request)) {
            return $response;
        }
        */
        $this->querySortValidate($request);

        $page = (int) $request->input('page');
        ${$obj} = $this->{$obj}Service->findByAccountId($accountId, $page);

        $resourceCollection = {$obj->upperCamel()}Resource::collection(${$obj});
        return $resourceCollection;
    }

    /**
     * GET show
     * 
     * @param Request $request
     * @param int $accountId
     * @param int ${$obj}Id
     * @return Response|{$obj->upperCamel()}Resource
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
     */
    public function store(Request $request, int $accountId): JsonResponse
    {
        $payload = $request->input('data');
        $new{$obj->upperCamel()} = new {$obj->upperCamel()}($payload);
        $new{$obj->upperCamel()}->account_id = $accountId;

        list($error, $code) = $this->storeValidate($request, $new{$obj->upperCamel()}, $accountId);
        if ($error) {
            return $this->error($error, $code);
        }

        ${$obj} = $this->{$obj}Service->add($new{$mod});
        $resource = new {$obj->upperCamel()}Resource(${$obj})
        // return $this->response($resource, 201);
        return    response()->json($resource, Response::HTTP_CREATED);  // 201 create
        // return response()->json($resource, Response::HTTP_ACCEPTED); // 202 job
    }

    /**
     * PATCH update
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

        list($error, $code) = $this->storeValidate($request, ${$obj}, $accountId);
        if ($error) {
            return $this->error($error, $code);
        }

        $this->{$obj}Service->update(${$obj});
        $resource = new {$obj->upperCamel()}Resource(${$obj})
        return $this->response($resource, 201);
    }

    /**
     * DELETE delete
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
    //  for ag-grid
    // --------------------------------------------------------------------------------

    /**
     * index
     */
    public function index(Request $request)
    {
        return response()->json([
            'data' => [
                'columnDefs' => [
                    [
                        "headerName" => "#",
                        "field"      => "id",
                    ],
                    [
                        "headerName" => "name",
                        "field"      => "name",
                    ],
                    [
                        "headerName" => "status",
                        "field"      => "status",
                    ],
                ],
                'rowData' => [
                    [
                        'id'     => 1,
                        'name'   => 'a',
                        'status' => 'aa',
                    ],
                    [
                        'id'     => 2,
                        'name'   =>'b',
                        'status' => 'bb',
                    ],
                    [
                        'id'     => rand(10,99),
                        'name'   =>'b2',
                        'status' => 'bb',
                    ],
                ],
            ],
        ]);


        $rowData = [];
        ${$obj} = $this->{$obj}Service->findByAccountId($accountId, $page);
        $resourceCollection = {$obj->upperCamel()}Resource::collection(${$obj});
        foreach ($resourceCollection as $resource) {
            $rowData[] = [
                'id'     => $resource->id,
                'name'   => $resource->name,
                'status' => $resource->status,
            ];
        }

        return response()->json([
            'data' => [
                'columnDefs' => [
                    [
                        "headerName" => "#",
                        "field"      => "id",
                    ],
                    [
                        "headerName" => "name",
                        "field"      => "name",
                    ],
                    [
                        "headerName" => "status",
                        "field"      => "status",
                    ],
                ],
                'rowData' => $rowData,
            ],
        ], Response::HTTP_OK);
    }

    // --------------------------------------------------------------------------------
    //  other
    // --------------------------------------------------------------------------------

    /**
     * @param Request $request
     * @param {$obj->upperCamel()} ${$obj}
     * @param int $accountId
     * @return array [error message, error code]
     */
    protected function storeValidate(Request $request, int $accountId): array
    {
        $validator = Validator::make($request->input('data'), [
            'required_keys'          => 'required|array|min:1',
            'required_keys.*'        => ['required', 'regex:/^(processor_id|card_type|subscription_plan)$/i'],
            'my_status'              => 'exists:enabled,disabled,draft,deleted',
            'my_status'              => Rule::in(['enabled', 'disabled', 'draft', 'deleted']),
            'my_status'              => new \Modules\YourNamespace\Http\Rules\MyRule,
            'my_status'              => 'required|string|min:1',
            'my_status_code'         => 'required|string|size:2',
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
     * @return array [error message, error code]
     */
    protected function accountValidate({$obj->upperCamel()} ${$obj}, int $accountId): array
    {
        if ((int) ${$obj}->account_id !== $accountId) {
            return ['account error', 404];
        }

        return [null, null];
    }

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
    protected function querySortValidate(Request $request)
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

    /**
     * @param Request $request
     * @return JsonResponse|null
     */
    protected function customValidate(Request $request): ?JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'name' => 'string',
            'type' => ["regex:/^(city|zip)$/i"],
        ]);

        $validator->after(function ($validator) use ($request) {
            if (false) {
                $validator->errors()->add('type', 'type is error');
            }
        });

        if ($validator->fails()) {
            return response()->json($validator->messages(), 400);
        }
        return null;
    }

    /**
     * custom validate
     * 
     * @param Request $request
     * @return array [error message, error code]
     */
    /*
    protected function customValidate(Request $request): array
    {
        $validator = Validator::make($request->all(), [
            'page'              => 'nullable|int|min:1',
            'order'             => 'nullable|array',
            'filter'            => 'nullable|array',
            'filter.name'       => 'string',
            'filter.status'     => ["regex:/^(enabled|disabled|draft)$/i"],
            'filter.created_at' => 'date_format:Y-m-d',
        ]);

        if ($validator->fails()) {
            return [$validator->errors()->first(), 400];
        }

        return [null, null];
    }
    */

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

    //
    // 下面的程式可能不需要
    // 試試這樣使用
    // return response()->json($accounts, 200);
    //
    /**
     * laravel response() 無法同時處理 JsonResource and return http status code
     *
     * @param JsonResource|array|null $resource
     * @param int $code
     * @return $this|Response|ResponseFactory
     */
    /*
    protected function response($resource = null, $code = 200)
    {
        if ($resource instanceof JsonResource) {
            return $resource->response()->setStatusCode($code);
        }
        else {
            return response($resource, $code);
        }
    }
     */

}

/**
 * @apiGroup {$obj->upperCamel()}
 * @apiName list
 * @api {ldelim}get{rdelim} /api/accounts/:account_id/{$mod->lower('-')}  list(具體說明)
 * @apiSampleRequest /api/accounts/:account_id/{$mod->lower('-')}
 * @apiParam {ldelim}int{rdelim}    account_id
 * @apiParam {ldelim}int{rdelim}    page
 * @apiParam {ldelim}int{rdelim}    filter[name]
 * @apiParam {ldelim}string{rdelim} filter[blog_id]
 *
 * @apiSuccessJson {ldelim}file=../../Tests/Data/Controllers/{$obj->lower('_')}_list_response.json{rdelim} Response: 200 OK
 * @apiSuccessExample Response: 200 OK
 *  {
 *      "data": []
 *      "links": []
 *      "meta": []
 *  }
 */

 /**
  * @apiGroup {$obj->upperCamel()}
  * @apiName show
  * @api {ldelim}get{rdelim} /api/accounts/:account_id/{$mod->lower('-')}/:{$obj}Id  show
  * @apiSampleRequest /api/accounts/:account_id/{$mod->lower('-')}/:{$obj}Id
  * @apiParam {ldelim}int{rdelim} account_id
  * @apiParam {ldelim}int{rdelim} {$obj}Id
  *
  * @apiSuccessJson {ldelim}file=../../Tests/Data/Controllers/{$obj->lower('_')}_show_response.json{rdelim} Response: 200 OK
  * @apiSuccessExample Response: 200 OK
  *  {
  *      "data": {
  *          "id": ""
  *      }
  *  }
  */

 /**
  * @apiGroup {$obj->upperCamel()}
  * @apiName store
  * @api {ldelim}post{rdelim} /api/accounts/:account_id/{$mod->lower('-')}  store(具體說明)
  * @apiParam {ldelim}int{rdelim} account_id
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
  *      -d @"Modules/{$obj->upperCamel()}/Tests/Data/Controllers/{$obj->lower('_')}_store.json"
  * @apiSuccessJson {ldelim}file=../../Tests/Data/Controllers/{$obj->lower('_')}_show_response.json{rdelim} Response: 201 Created
  * @apiSuccessExample Response: 201 Created
  *  {
  *      "data": {
  *          "id": ""
  *      }
  *  }
  */

 /**
  * @apiGroup {$obj->upperCamel()}
  * @apiName update
  * @api {ldelim}patch{rdelim} /api/accounts/:account_id/{$mod->lower('-')}/{$obj}Id  update
  * @apiParam {ldelim}int{rdelim} account_id
  * @apiParam {ldelim}int{rdelim} {$obj}Id
  *
  * @apiParamExample Request
  *  like "store"
  * @apiSuccessExample Response: 201
  *  like "store"
  */

 /**
  * @apiGroup {$obj->upperCamel()}
  * @apiName delete
  * @api {ldelim}delete{rdelim} /api/accounts/:account_id/{$mod->lower('-')}/{$obj}Id  delete
  * @apiParam {ldelim}int{rdelim} account_id
  * @apiParam {ldelim}int{rdelim} {$obj}Id
  *
  * @apiSuccessExample Response: 204 Not Content
  *  null
  */
