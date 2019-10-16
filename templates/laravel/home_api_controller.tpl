<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$mod->upperCamel()}\Http\Controllers;
{else        }namespace App\Http\Controllers;
{/if}

use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};
use App\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;

/*
$config = [
    'as' => '{$mod->lower('-')}',
    'middleware' => ['api'],
];
Route::group($config, function () {
    Route::get   ('/{$mod->lower('-')}',  {$obj->lowerCamel()|space_even:26}     '{$obj->upperCamel()}Controller@index');
    Route::get   ('/{$mod->lower('-')}/{ldelim}{$obj->lowerCamel()}Id{rdelim}',  '{$obj->upperCamel()}Controller@show');
    Route::post  ('/{$mod->lower('-')}',  {$obj->lowerCamel()|space_even:26}     '{$obj->upperCamel()}Controller@store');
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
class {$mod->upperCamel()}ApiController extends Controller
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
    public function index()
    {
        return 'index ';
    }

    /**
     * POST create
     */
    public function store(Request $request)
    {
        return 'store ';
    }

    /**
     * GET show
     */
    public function show($id)
    {
        return 'show ' . $id;
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
    //  private
    // --------------------------------------------------------------------------------


}
