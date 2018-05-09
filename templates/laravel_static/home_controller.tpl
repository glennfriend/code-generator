<?php
namespace App\Http\Controllers\Admin\______;

use Illuminate\Http\Request;
use App\Utility\Output\FormMessageManager;
use App\Http\Controllers\AdminController;
use App\Db\{$mod->upperCamel()};
use App\Db\{$obj->upperCamel()};
use App\Business\{$obj->upperCamel()}\{$obj->upperCamel()}Service;

/**
 *
 */
class Home extends AdminController
{

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

    /* --------------------------------------------------------------------------------
        private
    -------------------------------------------------------------------------------- */

    /**
     * @param Request $request
     * @param {$obj->upperCamel()} ${$obj}
     */
    private function modifyByCreatePost(Request $request, {$obj->upperCamel()} ${$obj})
    {
        if (! $request->isMethod('post')) {
            return;
        }

{foreach $tab as $key => $field}
{if $key=="id"}
{elseif $key=="properties"}
{elseif $key=="attribs"}
{elseif $key=="createAt"}
{elseif $key=="deleteAt"}
{elseif $key=="updateAt"}
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
    private function modifyByEditPost(Request $request, {$obj->upperCamel()} ${$obj})
    {
        $this->modifyByCreatePost($request, ${$obj});
    }


}
