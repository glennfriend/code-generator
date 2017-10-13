<?php
namespace App\Controllers\{$obj->upperCamel()};
use App\Business\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
use App\Model\{$mod->upperCamel()};
use App\Model\{$obj->upperCamel()};

/**
 *
 */
class HomeController extends AdminPageController
{

    /**
     *
     */
    protected function init()
    {
        MenuManager::setMain('your-main-name');

        if (!UserManager::isAdmin()) {
            redirectMainPage();
        }

        // blog
        $blogId = (int) InputBrg::get('blogId');
        if (!$blogId) {
            FormMessageManager::addErrorResultMessage('Can not find blog id');
            redirect('/blog');
        }
        $blogs = new Blogs();
        $this->_blog = $blogs->getBlog($blogId);
        if (!$this->_blog) {
            FormMessageManager::addErrorResultMessage('Can not find blog id');
            redirect('/blog');
        }

        /*
        $this->breadcrumbs = array(
            array('label'=>$this->blog->getName(), 'url'=>$this->createUrl('/blog', array('blogId'=>$this->_blogId)) ),
            array('label'=>$this->action->id,      'url'=>'' ),
        );
        */
    }

    /**
     *  index
     */
    protected function index()
    {
        MenuManager::setSub('your-sub-name');

        $page = (int) InputBrg::get('page');
        $findKeys = $this->parseFind(InputBrg::get('findKeys'));
        list($sortBy, $sortField, $order) = $this->parseOrder(
            InputBrg::get('sortField'),
            InputBrg::get('sortBy')
        );

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
     *  new
     */
    protected function newAction()
    {
        $object = new {$obj->upperCamel()}();

        do {
            // add only
            if (!InputBrg::isPost()) {
                break;
            }

            $object = $this->_postProcess($object);
            if ($fieldMessages = $object->validate()) {
                FormMessageManager::addErrorResultMessage('Error');
                FormMessageManager::setFieldMessages($fieldMessages);
                break;
            }

            $object = {$obj->upperCamel()}Service::add($object);
            /*
                if (!$object instanceof {$obj->upperCamel()}) {
                    // error
                }
            */
            if ($error = {$obj->upperCamel()}Service::getError()) {
                FormMessageManager::addErrorResultMessage($error);  // '新增失敗, 發現有重覆的資料, 請使用其它名稱'
                FormMessageManager::addFieldMessage( array('____name____' => '發現有重覆的資料, 請使用其它名稱') );
                FormMessageManager::addFieldMessage( array('____mail____' => '發現有重覆的資料, 請使用其它電子郵件') );
                break;
            }

            FormMessageManager::addSuccessResultMessage('Success');
            redirect('/index', [
                'id' => $this->_blog->getId()
            ]);

        } while(false);

        // new & add
        $this->render('{$obj}.home.newAction', [
            'blogId' => $this->_blog->getId(),
            '{$obj}' => $object,
        ]);
    }

    /**
     *  edit
     */
    protected function editAction()
    {
        ${$mod} = new {$mod->UpperCamel()}();
        $objectId = (int) InputBrg::get('{$obj}Id');
        $object   = ${$mod}->get{$obj->upperCamel()}($objectId);
        if (!$object) {
            redirect('/index');
        }

        do {
            // update only
            if (!InputBrg::isPost()) {
                break;
            }

            $object = $this->_postProcess($object);
            if ($fieldMessages = $object->validate()) {
                FormMessageManager::addErrorResultMessage('Error');
                FormMessageManager::setFieldMessages( $fieldMessages );
                break;
            }

            {$obj->upperCamel()}Service::update($object);
            if ($error = {$obj->upperCamel()}Service::getError()) {
                FormMessageManager::addErrorResultMessage($error);  // '更新失敗, 發現有重覆的資料, 請使用其它名稱'
                FormMessageManager::addFieldMessage( array('____name____' => '發現有重覆的資料, 請使用其它名稱') );
                FormMessageManager::addFieldMessage( array('____mail____' => '發現有重覆的資料, 請使用其它電子郵件') );
                break;
            }

            FormMessageManager::addSuccessResultMessage('Update success');

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

        } while(false);

        // edit & update
        $this->render('{$obj}.home.editAction', array(
            '{$obj}' => $object,
        ));

    }

    /**
     *  post process
     *  @param object
     *  @return object
     */
    protected function _postProcess({$obj->UpperCamel()} ${$obj})
    {
        if (!InputBrg::isPost()) {
            return ${$obj};
        }

{foreach $tab as $key => $field}
{if $key=="id"}
{elseif $key=="properties"}
        // properties
{elseif $key=="customSearch"}
        // customSearch
{elseif $key=="createTime"}
        // createTime
{elseif $key=="updateTime"}
        ${$obj}->{$field.name->set()}{$key|space_even} ( time() );
{elseif $field.ado->type=="timestamp" || $field.ado->type=="date" || $field.ado->type=="datetime"}
        ${$obj}->{$field.name->set()}{$key|space_even} ( strtotime(InputBrg::post('{$field.ado->name}')){$field.ado->name|space_even:29} );
{else}
        ${$obj}->{$field.name->set()}{$key|space_even} ( InputBrg::post('{$field.ado->name}'){$field.ado->name|space_even:40} );
{/if}
{/foreach}
        return ${$obj};
    }

    /**
     *  delete
     */
    protected function actionDelete()
    {
        $chooseItems = InputBrg::post('chooseItems');
        if (!$chooseItems) {
            FormMessageManager::addErrorResultMessage('You not choose any item');
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
            FormMessageManager::addSuccessResultMessage('Delete success ('. join(', ',$successIds) .')');
        }
        if ($failIds) {
            FormMessageManager::addErrorResultMessage('Delete fail ('. join(', ',$failIds) .')');
        }

        $params = array(
            'parentId' => $this->_parent->getParentId(),
        );
        $page = InputBrg::post('page');
        if ($page > 1) {
            $params['page'] = $page;
        }
        redirect('/index', $params);
    }

    /**
     *  myself setting
     */
    protected function settingAction()
    {
        exit;

        $blogs = new Blogs();
        $blogId = ??????????????????
        if ( !$blogId || !$blog = $blogs->getBlog($blogId) ) {
            redirect('admin/');
        }

        // update setting
        if ( InputBrg::isPost() ) {
            $posts = get post .....
            // set ......
            // ..........
        }

        // setting
        $this->render('{$obj}.home.setting',array(
            '' => '',
        ));
    }

    /* --------------------------------------------------------------------------------
        處理 table list 的相關參數: sortField, sortBy, findKeys
    -------------------------------------------------------------------------------- */

    /**
     *  使用白名單過濾參數, 只予許特定欄位做 custom find
     *  @return array
     */
    private function getAllowFind()
    {
        return [
{foreach from=$tab key=key item=field}
            '{$key}',
{/foreach}
        ];
    }

    /**
     *  custom find keys
     *  @return array - 所有予許的 findKeys 欄位資料
     */
    private function parseFind($findKeys)
    {
        if ( !is_array($findKeys) ) {
            // default
            $findKeys = [];
        }

        $allows = array();
        foreach( $this->getAllowFind() as $name ) {
            $allows[$name] = isset($findKeys[$name]) ? trim(strip_tags($findKeys[$name])) : '';
        }
        return $allows;
    }


    /**
     *  get default order by
     *  @return array
     */
    private function getDefaultOrderBy()
    {
        return ['id', 'asc'];
    }

    /**
     *  使用白名單過濾參數, 只予許特定欄位做 order by
     *  @return boolean
     */
    private function isAllowOrderField($fieldName)
    {
        $mapping = [
{foreach from=$tab key=key item=field}
            '{$key}',
{/foreach}
        ];
        if (in_array($fieldName, $mapping)) {
            return true;
        }
        return false;
    }

    /**
     *  field sort information
     */
    private function parseOrder($sortField, $sortBy)
    {
        $sortField = trim(strip_tags($sortField));
        $sortBy    = ($sortBy==='desc') ? 'desc' : 'asc';

        // default
        if (!$sortField) {
            list($sortField, $sortBy) = $this->getDefaultOrderBy();
        }

        if ($this->isAllowOrderField($sortField)) {
            $order = $sortField .','. $sortBy;
        }
        else {
            $order = '';
            $sortField = '';
        }

        return [$sortBy, $sortField, $order];
    }

    // 以上

}
