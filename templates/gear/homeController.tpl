<?php

/**
 *
 */
class HomeController extends ControllerBase
{

    /**
     *
     */
    public function initialize()
    {
        parent::initialize();

        // disabled layout, use action view
        // $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_LAYOUT);

        if ( !UserManager::isAdmin() ) {
            $this->redirectMainPage();
        }

        // sub menu and label
        // $this->plugin->focusSubMenu('index');
        // $this->label = $this->plugin->getFocusSubMenuByValue('label');
        // $this->label = $this->plugin->getFocusSubMenuByValue('label') .' '. $this->action->id;


        // blog
        $blogId = (int) InputBrg::get('blogId');
        if ( !$blogId ) {
            FormMessageManager::addErrorResultMessage('Can not find blog id');
            $this->redirect('/blog');
        }
        $blogs = new Blogs();
        $this->_blog = $blogs->getBlog($blogId);
        if ( !$this->_blog ) {
            FormMessageManager::addErrorResultMessage('Can not find blog id');
            $this->redirect('/blog');
        }

        $this->breadcrumbs = array(
            array('label'=>$this->blog->getName(), 'url'=>$this->createUrl('/blog', array('blogId'=>$this->_blogId)) ),
            array('label'=>$this->action->id,      'url'=>'' ),
        );

        return true;
    }

    /**
     *  index
     */
    public function indexAction()
    {
        $page = (int) InputBrg::get('page');
        $findKeys = $this->parseFind(InputBrg::get('findKeys'));
        list($sortBy, $sortField, $order) = $this->parseOrder(
            InputBrg::get('sortField'),
            InputBrg::get('sortBy')
        );

        $options = array_filter([
{foreach from=$tab key=key item=field}
            '{$key}'{$key|space_even} => $findKeys['{$key}'],
{/foreach}

            'status'               => {$obj->upperCamel()}::STATUS_ALL,
            '_page'                => $page,
            '_order'               => $order
        ]);
        ${$mod}   = new {$mod->upperCamel()}();
        $my{$mod->upperCamel()} = ${$mod}->find{$mod->upperCamel()}( $options );
        $rowCount     = ${$mod}->numFind{$mod->upperCamel()}( $options );

        $pageLimit = new PageLimit();
        $pageLimit->setBaseUrl( '______module______/home/index' );  // 請使用完整的 mca 命名
        $pageLimit->setRowCount( $rowCount );
        $pageLimit->setPage( $page );
        $pageLimit->setParams([
            'sortField' => $sortField,
            'sortBy'    => $sortBy,
            'findKeys'  => array_filter($findKeys),
        ]);

        $this->view->setVars([
            '{$mod}' => $my{$mod->upperCamel()},
            'pageLimit' => $pageLimit,
        ]);
    }

    /**
     *  new
     */
    public function newAction()
    {
        ${$obj} = new {$obj->upperCamel()}();

        // add only
        if ( InputBrg::isPost() ) {

            ${$obj} = $this->_postProcess( ${$obj} );
            if ( $fieldMessages = ${$obj}->validate() ) {
                FormMessageManager::addErrorResultMessage('Error');
                FormMessageManager::setFieldMessages( $fieldMessages );
            }
            else {
                ${$mod} = new {$mod->upperCamel()}();
                if ( ${$mod}->add{$obj->upperCamel()}(${$obj}) ) {
                    FormMessageManager::addSuccessResultMessage('Success');
                    $this->redirect( $this->createUrl('index', array('id'=>$this->_blog->getId())) );
                }
                // add fail
                FormMessageManager::addErrorResultMessage('新增失敗, 發現有重覆的資料, 請使用其它名稱');
                FormMessageManager::addFieldMessage( array('____name____' => '發現有重覆的資料, 請使用其它名稱') );
                FormMessageManager::addFieldMessage( array('____mail____' => '發現有重覆的資料, 請使用其它電子郵件') );
            }

        }

        // new and add
        $this->render( 'new', array(
            'blogId'    => $this->_blog->getId(),
            '{$obj}' => ${$obj},
        ));
        $this->view->setVars(array(
            'blogId'    => $this->_blog->getId(),
            '{$obj}' => ${$obj},
        ));
    }

    /**
     *  edit
     */
    public function editAction()
    {
        ${$obj}Id = (int) InputBrg::get('{$obj}Id');
        ${$mod} = new {$mod->UpperCamel()}(); 
        ${$obj} = ${$mod}->get{$obj->upperCamel()}(${$obj}Id);
        if (!${$obj}) {
            $this->redirect( $this->createUrl('index') );
        }

        // update only
        if ( InputBrg::isPost() ) {

            ${$obj} = $this->_postProcess( ${$obj} );
            if ( $fieldMessages = ${$obj}->validate() ) {
                FormMessageManager::addErrorResultMessage('Error');
                FormMessageManager::setFieldMessages( $fieldMessages );
            }
            else {
                if ( ${$mod}->update{$obj->upperCamel()}(${$obj}) ) {
                    FormMessageManager::addSuccessResultMessage('Update success');
                    $this->redirect( $this->createUrl('index', array('blogId'=>$this->_blog->getId())) );
                  //$this->redirect( $this->createUrl('edit',  array('blogId'=>$this->_blog->getId()),'{$obj}Id'=>${$obj}Id)) );
                }
                // update fail
                FormMessageManager::addErrorResultMessage('更新失敗, 發現有重覆的資料, 請使用其它名稱');
                FormMessageManager::addFieldMessage( array('____name____' => '發現有重覆的資料, 請使用其它名稱') );
                FormMessageManager::addFieldMessage( array('____mail____' => '發現有重覆的資料, 請使用其它電子郵件') );
            }

        }

        // edit and update
        $this->render( 'edit', array(
            '{$obj}' => ${$obj},
        ));

    }

    /**
     *  post process
     *  @param object
     *  @return object
     */
    protected function _postProcess( ${$obj} )
    {
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
    public function actionDelete()
    {
        $chooseItems = InputBrg::post('chooseItems');
        if ( !$chooseItems ) {
            FormMessageManager::addErrorResultMessage('You not choose any item');
            $this->redirect( $this->createUrl('index', array('parentId'=>$this->_parent->getParentId()) ));
        }

        $myself = UserManager::getUser();
        $myselfId = $myself->getId();

        $successIds = array();
        $failIds = array();
        ${$mod} = new {$mod->UpperCamel()}();
        foreach ( $chooseItems as $itemId ) {
            $itemId = (int) $itemId;
            if ( ${$mod}->delete{$obj->upperCamel()}($itemId, $myselfId) ) {
                $successIds[] = $itemId;
            }
            else {
                $failIds[] = $itemId;
            }
        }

        if ( $successIds ) {
            FormMessageManager::addSuccessResultMessage('您刪除了('. join(', ',$successIds) .')');
        }
        if ( $failIds ) {
            FormMessageManager::addErrorResultMessage('無法刪除('. join(', ',$failIds) .')');
        }

        $params = array(
            'parentId' => $this->_parent->getParentId(),
        );
        $page = InputBrg::post('page');
        if ( $page > 1 ) {
            $params['page'] = $page;
        }
        $this->redirect( $this->createUrl('index',$params) );
    }

    /**
     *  myself setting
     */
    public function settingAction()
    {
        exit;

        $blogs = new Blogs();
        $blogId = ??????????????????
        if ( !$blogId || !$blog = $blogs->getBlog($blogId) ) {
            $this->redirect('admin/');
        }

        // update setting
        if ( InputBrg::isPost() ) {
            $posts = get post .....
            // set ......
            // ..........
        }

        // setting
        $this->render('setting',array(
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
    public function getAllowFind()
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
    public function parseFind($findKeys)
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
    public function getDefaultOrderBy()
    {
        return ['id', 'asc'];
    }

    /**
     *  使用白名單過濾參數, 只予許特定欄位做 order by
     *  @return boolean
     */
    public function isAllowOrderField($fieldName)
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
    public function parseOrder($sortField, $sortBy)
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
