<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Http\Controllers;
{else        }namespace App\Http\Controllers;
{/if}

use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Routing\Redirector;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$mod->upperCamel()};
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
{else}
use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};
use App\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
{/if}

/**
 *
 */
class {$obj->upperCamel()}Controller extends Controller
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
     * @param Request $request
     * @param ${$obj}Id
     * @return JsonResponse
     */
    public function index(Request $request, ${$obj}Id)
    {
        return response()->view('admin.{$obj->lower("-")}.index');

        /*
        return view('admin.{$obj->lower("-")}.campaigns-budget.index', [
            '{$mod}' => [],
        ]);
        */
    }

    /**
     * @param string|null ${$obj}Id
     * @return Response|Redirector|RedirectResponse
     */
    public function redirectExample(string ${$obj}Id = null)
    {
        if (!${$obj}Id) {
            ${$obj} = $this->repository->find($defaultId = 100);
            if (!${$obj}) {
                return abort(404);
            }
            $redirectUrl = "/accounts/{ldelim}${$obj}->id{rdelim}/{$obj->lower("-")}/index";
            echo $redirectUrl; exit;
            return redirect($redirectUrl);
        }
        $account = $this->repository->find(${$obj}Id);

        return response()->view('...');
    }





    /**
     * ????????????????
     * 
     * @param Request $request
     * @param ${$obj}Id
     * @return JsonResponse
     */
    public function index(Request $request, ${$obj}Id)
    {
        try {
            // 
        }
        catch (Exception $e) {
            return response()->json([], 200);
        }

        //
        return response()->json([], 200);
    }



    /**
     * !!!! 這裡暫時不更新, 請使用 HomeApi 的程式 !!!!
     * 
     * input validate example
     */
    public function inputValidate__Example(Request $request)
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

        // return response()->json(????);
    }


    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     * example
     *      $output = $this->reportOutput($results, $query['group_keys'];
     *      response()->json($output));
     */
    protected function reportOutput(array $data, array $groupKeys): array
    {
        $results = [
            'column_defs' => $this->convertColumnDefs($groupKeys),
            'fields'      => [],
            'data'        => $this->convertData($data, $groupKeys),
        ];
        // echo '<pre>' . json_encode($results, JSON_PRETTY_PRINT); exit;
        return $results;
    }

    protected function convertColumnDefs(array $groupKeys)
    {
        $column = [];
        if (in_array('status', $groupKeys)) {
            $column[] = [
                'header_name'   => '[Status]',
                'field'         => 'status'
            ];
        }

        return array_merge(
            $column,
            [
                ['header_name' => 'Attempt Count',                  'field' => 'attempt_count'],
                ['header_name' => 'Authorization Success Count',    'field' => 'authorization_success_count'],
                ['header_name' => 'Activation Success Count',       'field' => 'activation_success_count'],
            ]
        );
    }

    protected function convertData($data, array $groupKeys)
    {
        $results = [];
        foreach ($data as $row) {
            $results[] = [
                'attempt_count'                 => (int) data_get($row, 'attempt_count'),
                'authorization_success_count'   => (int) data_get($row, 'authorization_success_count'),
                'activation_success_count'      => (int) data_get($row, 'activation_success_count'),
            ];
        }

        return $results;
    }












    /**
     *
     */
    public function init()
    {
        /*
        // blog
        $blogId = (int) InputBrg::get('blogId');
        if (! $blogId) {
            FormMessageManager::addErrorResult('Can not find blog id');
            redirect('/blog');
        }
        $blogs = new Blogs();
        $this->_blog = $blogs->getBlog($blogId);
        if (!$this->_blog) {
            FormMessageManager::addErrorResult('Can not find blog id');
            redirect('/blog');
        }
        */

        view()->share('menuMain', '{$obj}');
        view()->share('menuSub',  '{$obj}-list');
    }

    /**
     *  index
     */
    public function index(int $parentId)
    {
        ${$mod} = {$mod->upperCamel()}::getMany('parent_id', $parentId);

        return view('admin.{$obj}.index', [
            '{$mod}' => ${$mod},
            'menuSub' => '',
        ]);





        $fields = array_filter([
{foreach from=$tab key=key item=field}
            '{$key}'{$key|space_even} => $findKeys['{$key}'],
{/foreach}

            'status'               => {$obj->upperCamel()}::STATUS_ALL,
        ]);
        $options = [
            'page' => $page,
        ];
        ${$mod}   = new {$mod->upperCamel()}();
        $my{$mod->upperCamel()} = ${$mod}->find{$mod->upperCamel()}($fields, $options);
        $rowCount{$mod->upperCamel()|space_even}         = ${$mod}->numFind{$mod->upperCamel()}($fields, $options);

        $pageLimit = new PageLimit();
        $pageLimit->setBaseUrl('/your-route');
        $pageLimit->setRowCount($rowCount);
        $pageLimit->setPage($page);
        $pageLimit->setParams([
            'sortField' => $sortField,
            'sortBy'    => $sortBy,
            'findKeys'  => array_filter($findKeys),
        ]);

        $this->render('{$obj}.home.index', [
            '{$mod}' => $my{$mod->upperCamel()},
            'pageLimit' => $pageLimit,
        ]);
    }

    /**
     *  create & add
     */
    protected function create(Request $request)
    {
        $object = new {$obj->upperCamel()}();

        do {
            // add only
            if (! $request->isMethod('post')) {
                break;
            }

            $this->modifyByCreatePost($object);
            if ($fieldMessages = $object->validate()) {
                FormMessageManager::addErrorResult('{$mod->upperCamel()} validate fail');
                FormMessageManager::setFields($fieldMessages);
                break;
            }

            if (! {$obj->upperCamel()}Service::add($object)) {
                FormMessageManager::addErrorResult();
                break;
            }

            $object = {$obj->upperCamel()}Service::add($object);
            if (! $object instanceof {$obj->upperCamel()}) {
                echo 'Error 534252534';
                exit;
            }

            /*
            if ($error = {$obj->upperCamel()}Service::getError()) {
                FormMessageManager::addErrorResult($error);  // '新增失敗, 發現有重覆的資料, 請使用其它名稱'
                FormMessageManager::addField( array('____name____' => '發現有重覆的資料, 請使用其它名稱') );
                FormMessageManager::addField( array('____mail____' => '發現有重覆的資料, 請使用其它電子郵件') );
                break;
            }
            */

            FormMessageManager::addSuccessResult();
            return redirect(url()->current());

        } while(false);

        // create & add
        $this->render('{$obj}.home.{$obj}-create', [
            'blogId' => $this->_blog->getId(),
            '{$obj}' => $object,
        ]);
    }

    /**
     *  edit & update
     */
    public function edit(Request $request, int ${$obj}Id)
    {
        ${$obj} = {$mod->UpperCamel()}::get(${$obj}Id);
        if (! ${$obj}) {
            return redirect(admin_url('/dashboard'));
        }

        do {
            // update only
            if (! $request->isMethod('post')) {
                break;
            }

            $this->modifyByEditPost($request, ${$obj});
            if ($fieldMessages = ${$obj}->validate()) {
                FormMessageManager::addErrorResult('{$obj->UpperCamel()} validate fail');
                FormMessageManager::setFields($fieldMessages);
                break;
            }

            if (! {$mod->UpperCamel()}Service::update(${$obj})) {
                FormMessageManager::addErrorResult();    // '更新失敗, 發現有重覆的資料, 請使用其它名稱'
                // FormMessageManager::addField( array('____name____' => '發現有重覆的資料, 請使用其它名稱') );
                // FormMessageManager::addField( array('____mail____' => '發現有重覆的資料, 請使用其它電子郵件') );
                break;
            }

            FormMessageManager::addSuccessResult();
            return redirect(url()->current());

            /*
            $stayCurrentPage = true;
            if ($stayCurrentPage) {
                // 留在原本修改的頁面
                redirect('/edit',  [
                    'blogId'   => $this->_blog->getId()),
                    '{$obj}Id' => $objectId)
                ]);
            }
            else {
                // 跳轉到其它頁面
                redirect('/index', [
                    'blogId' => $this->_blog->getId()
                ]);
            }
            */

        } while(false);

        // edit & update
        return view('admin.{$obj}.edit', [
            '{$obj}' => ${$obj},
            'menuSub' => '',
        ]);
    }

    /**
     *  delete
     */
    protected function delete(Request $request)
    {
        /*
        $chooseItems = $request->post('chooseItems');
        if (! $chooseItems) {
            FormMessageManager::addErrorResult('You not choose any item');
            redirect('/index', [
                'parentId' => $this->_parent->getParentId()
            ]);
        }

        $successIds  = [];
        $failIds     = [];
        foreach ($chooseItems as $id) {
            if ({$obj->upperCamel()}Service::delete($id)) {
                $successIds[] = $id;
            }
            else {
                $failIds[] = $id;
            }
        }

        if ($successIds) {
            FormMessageManager::addSuccessResult('Delete success ('. join(', ',$successIds) .')');
        }
        if ($failIds) {
            FormMessageManager::addErrorResult('Delete fail ('. join(', ',$failIds) .')');
        }

        $params = array(
            'parentId' => $this->_parent->getParentId(),
        );
        $page = InputBrg::post('page');
        if ($page > 1) {
            $params['page'] = $page;
        }
        redirect('/index', $params);
        */
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     * @param Request $request
     * @param {$obj->upperCamel()} ${$obj}
     */
    protected function modifyByCreatePost(Request $request, {$obj->upperCamel()} ${$obj})
    {
        if (! $request->isMethod('post')) {
            return;
        }

{foreach $tab as $key => $field}
{if $key=="id"}
{elseif $key=="properties"}
{elseif $key=="attribs"}
{elseif $key=="createdAt"}
{elseif $key=="deletedAt"}
{elseif $key=="updatedAt"}
        ${$obj}->{$field.name->set()}{$key|space_even} ( time()                                                     );
{elseif $field.ado->type=="timestamp" || $field.ado->type=="date" || $field.ado->type=="datetime"}
        ${$obj}->{$field.name->set()}{$key|space_even} ( strtotime($request->post('{$field.ado->name}')){$field.ado->name|space_even:29} );
{else}
        ${$obj}->{$field.name->set()}{$key|space_even} ( $request->post('{$field.ado->name}'){$field.ado->name|space_even:40} );
{/if}
{/foreach}
    }

    /**
     * @param Request $request
     * @param {$obj->upperCamel()} ${$obj}
     */
    protected function modifyByEditPost(Request $request, {$obj->upperCamel()} ${$obj})
    {
        $this->modifyByCreatePost($request, ${$obj});
    }


}
