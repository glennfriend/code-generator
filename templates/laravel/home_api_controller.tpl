<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Api\Controllers;
{else        }namespace App\Http\Api\Controllers;
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
    //  private
    // --------------------------------------------------------------------------------

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
