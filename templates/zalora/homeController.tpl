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
            $this->redirect( $this->createUrl('/admin') );
            return false;
        }

        $blogId = (int) CHttpRequest::getParam('blogId');
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
    public function actionIndex( $searchKey='', $page=1 )
    {
        $page        = (int) $page;
        $searchKey   = trim(strip_tags($searchKey));

        $options = array(
            'userId'       => $userId,
            'status'       => {$oName3}::STATUS_ALL,
            'searchKey'    => $searchKey,
            'page'         => $page
        );
        ${$mName2}   = new {$mName3}();
        $my{$mName3} = ${$mName2}->find{$mName3}( $options );
        $rowCount    = ${$mName2}->getNum{$mName3}( $options );
     // $my{$mName3} = ${$mName2}->find{$mName3}( $status={$oName3}::STATUS_OPEN, $searchKey, $page );
     // $rowCount    = ${$mName2}->getNum{$mName3}( $status={$oName3}::STATUS_OPEN, $searchKey );

        $this->pageLimit = new PageLimit();
        $this->pageLimit->setBaseUrl( '______module______/home/index' );  // 請使用完整的 mca 命名
        $this->pageLimit->setRowCount( $rowCount );
        $this->pageLimit->setPage( $page );
        $this->pageLimit->setParams(array(
            'searchKey' => $searchKey,
        ));

        $this->render( $this->getAction()->getId(), array(
            'searchKey' => $searchKey,
            '{$mName2}' => $my{$mName3},
        ));
    }

    /**
     *  new
     */
    public function actionNew()
    {
        ${$oName2} = new {$oName3}();

        // add only
        if ( CHttpRequest::getIsPostRequest() ) {

{foreach $vName5 as $key => $val}
{if $vName5.$key=="id"}
{elseif $vName5.$key=="properties"}
{elseif $vName5.$key=="create_time" || $vName5.$key=="update_time"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( time() );
{elseif $fieldType.$key=="timestamp" || $fieldType.$key=="date" || $fieldType.$key=="datetime"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( strtotime(CHttpRequest::getPost('{$vName2.$key}')) );
{else}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( CHttpRequest::getPost('{$vName2.$key}'){$vName2.$key|space_even} );
{/if}
{/foreach}
            ${$oName2}->filter();

            if ( $fieldMessages = ${$oName2}->validate() ) {
                FormMessageManager::setFieldMessages( $fieldMessages );
                FormMessageManager::addErrorResultMessage('Error');
            }
            else {
                ${$mName2} = new {$mName3}();
                if ( ${$mName2}->add{$oName3}(${$oName2}) ) {
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
            '{$oName2}' => ${$oName2},
        ));

    }

    /**
     *  edit
     */
    public function actionEdit()
    {
        ${$oName2}Id = (int) CHttpRequest::getParam('{$oName2}Id');
        ${$mName2} = new {$mName3}();
        ${$oName2} = ${$mName2}->get{$oName3}(${$oName2}Id);
        if (!${$oName2}) {
            $this->redirect( $this->createUrl('index') );
        }

        // update only
        if ( CHttpRequest::getIsPostRequest() ) {

{foreach $vName5 as $key => $val}
{if $vName5.$key=="id"}
{elseif $vName5.$key=="properties"}
{elseif $vName5.$key=="create_time"}
{elseif $vName5.$key=="update_time"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( time() );
{elseif $fieldType.$key=="timestamp" || $fieldType.$key=="date" || $fieldType.$key=="datetime"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( strtotime(CHttpRequest::getPost('{$vName2.$key}')) );
{else}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( CHttpRequest::getPost('{$vName2.$key}'){$vName2.$key|space_even} );
{/if}
{/foreach}
            ${$oName2}->filter();

            if ( $fieldMessages = ${$oName2}->validate() ) {
                FormMessageManager::setFieldMessages( $fieldMessages );
                FormMessageManager::addErrorResultMessage('Error');
            }
            else {
                if ( ${$mName2}->update{$oName3}(${$oName2}) ) {
                    FormMessageManager::addSuccessResultMessage('Update success');
                    $this->redirect( $this->createUrl('index', array('blogId'=>$this->_blog->getId())) );
                  //$this->redirect( $this->createUrl('edit',  array('blogId'=>$this->_blog->getId()),'{$oName2}Id'=>${$oName2}Id)) );
                }
                // update fail
                FormMessageManager::addErrorResultMessage('更新失敗, 發現有重覆的資料, 請使用其它名稱');
                FormMessageManager::addFieldMessage( array('____name____' => '發現有重覆的資料, 請使用其它名稱') );
                FormMessageManager::addFieldMessage( array('____mail____' => '發現有重覆的資料, 請使用其它電子郵件') );
            }

        }

        // edit and update
        $this->render( $this->getAction()->getId(), array(
            '{$oName2}' => ${$oName2},
        ));

    }

    /**
     *  delete
     */
    public function actionDelete()
    {
        $chooseItems = CHttpRequest::getPost('chooseItems');
        if ( !$chooseItems ) {
            FormMessageManager::addErrorResultMessage('You not choose any item');
            $this->redirect( $this->createUrl('index', array('parentId'=>$this->_parent->getParentId()) ));
        }

        $myself = UserManager::getUser();
        $myselfId = $myself->getId();

        $successIds = array();
        $failIds = array();
        ${$mName2} = new {$mName3}();
        foreach ( $chooseItems as $itemId ) {
            $itemId = (int) $itemId;
            if ( ${$mName2}->delete{$oName3}($itemId, $myselfId) ) {
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
        $page = CHttpRequest::getPost('page');
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
        if ( CHttpRequest::getIsPostRequest() ) {
            $posts = get post .....
            // set ......
            // ..........
        }

        // setting
        $this->render('setting',array(
            '' => '',
        ));
    }

}
