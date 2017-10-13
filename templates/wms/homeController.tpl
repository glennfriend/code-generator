<?php

/**
 *
 */
class HomeController extends AdminBaseController
{
    /**
     *  before
     */
    public function beforeAction($action)
    {
        parent::beforeAction($action);

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
    public function actionIndex( $page=1 )
    {
        $findKeys = $this->_getIndexCustomFind();
        list( $sortBy, $sortField, $order ) = $this->_getIndexFieldSort();  // order by

        $options = array_filter(array(
{foreach from=$tab key=key item=field}
            '{$key}'{$key|space_even} => $findKeys['{$key}'],
{/foreach}

            'status'               => {$obj->upperCamel()}::STATUS_ALL,
            '_searchKey'           => $searchKey,
            '_page'                => $page
        ));
        ${$mod}   = new {$mod->upperCamel()}();
        $my{$mod->upperCamel()} = ${$mod}->find{$mod->upperCamel()}( $options );
        $rowCount     = ${$mod}->numFind{$mod->upperCamel()}( $options );

        $this->pageLimit = new PageLimit();
        $this->pageLimit->setBaseUrl( '______module______/home/index' );  // 請使用完整的 mca 命名
        $this->pageLimit->setRowCount( $rowCount );
        $this->pageLimit->setPage( $page );
        $this->pageLimit->setParams(array(
            'sortField' => $sortField,
            'sortBy'    => $sortBy,
            'findKeys'  => array_filter($findKeys),
        ));

        $this->render( 'index', array(
            '{$mod}' => $my{$mod->upperCamel()},
        ));
    }

    /**
     *  new
     */
    public function actionNew()
    {
        ${$obj} = new {$obj->upperCamel()}();

        // add only
        if ( InputBrg::isPost() ) {

            list($errorMessage, ${$obj}] = $this->_postProcess(${$obj});
            if ($errorMessage) {
                FormMessageManager::addErrorResultMessage('Error - '. $errorMessage);                
            }
            elseif ( $fieldMessages = ${$obj}->validate() ) {
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

    }

    /**
     *  edit
     */
    public function actionEdit()
    {
        ${$obj}Id = (int) InputBrg::get('{$obj}Id');
        ${$mod} = new {$mod->UpperCamel()}(); 
        ${$obj} = ${$mod}->get{$obj->upperCamel()}(${$obj}Id);
        if (!${$obj}) {
            $this->redirect( $this->createUrl('index') );
        }

        // update only
        if ( InputBrg::isPost() ) {

            list($errorMessage, ${$obj}] = $this->_postProcess(${$obj});
            if ($errorMessage) {
                FormMessageManager::addErrorResultMessage('Error - '. $errorMessage);                
            }
            elseif ( $fieldMessages = ${$obj}->validate() ) {
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
     *  @return [message, object] array
     */
    protected function _postProcess({$obj->UpperCamel()} ${$obj})
    {
        $missFields = [];
{foreach $tab as $key => $field}
{if in_array($key, ['id','properties','createTime','updateTime'])}
{else}
        if (null===InputBrg::post('{$field.ado->name}')){$field.ado->name|space_even:26} { $missFields[] = '{$field.ado->name}';{$field.ado->name|space_even:26} }
{/if}
{/foreach}
        if ($missFields) {
            return [
                "Lack for '" . join(', ', $missFields) . "'",
                null
            ];
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
        return [
            null,
            ${$obj}
        ];
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
    public function actionSetting()
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
        helper method
    -------------------------------------------------------------------------------- */

    /**
     *  index - custom find keys
     *  @return array - 所有予許的 findKeys 欄位資料
     */
    protected function _getIndexCustomFind()
    {
        $findKeys = InputBrg::get('findKeys');
        if ( !is_array($findKeys) ) {
            $findKeys = array(); // default
        }

        // 使用白名單過濾參數, 只予許特定欄位做 custom find
        $nameMapping = array(
{foreach from=$tab key=key item=field}
            '{$key}',
{/foreach}
        );

        $cleanFindKeys = array();
        foreach( $nameMapping as $name ) {
            $cleanFindKeys[$name] = isset($findKeys[$name]) ? trim(strip_tags($findKeys[$name])) : '';
        }
        return $cleanFindKeys;
    }

    /**
     *  index - field sort information
     */
    protected function _getIndexFieldSort()
    {
        $order     = '';
        $sortBy    = InputBrg::get('sortBy')==='desc' ? 'desc' : 'asc';
        $sortField = trim(strip_tags(InputBrg::get('sortField')));

        // default
        if ( !$sortField ) {
            $sortField = 'id';
            $sortBy = 'desc';
        }

        // validate
        $fieldMapping = array(
{foreach from=$tab key=key item=field}
            '{$key}'{$key|space_even} => '{$field.name->lower("_")}',
{/foreach}
        );
        if ( isset($fieldMapping[$sortField]) ) {
            $order = $fieldMapping[$sortField] .' '. $sortBy;
        }
        else {
            $sortField = '';
        }

        return array( $sortBy, $sortField, $order );
    }


}
