<?php

/**
 *  
 */
class Admin{$oName3}Controller extends AdminBaseController
{
    /**
     *  before ...
     */
    public function beforeAction($action)
    {
        parent::beforeAction($action);
        $this->menus->setFocusByAction('admin{$oName3}/list');
        return true;
    }

    /**
     *  index
     */
    public function actionIndex()
    {
        Request::redirect('list');
    }

    /**
     *  list
     */
    public function actionList( $page=1, $searchKey='' )
    {
        if( Request::isPost() ) {
            $posts = Request::getPostInfo();
            if( $posts['searchKey'] ) {
                $searchKey = $posts['searchKey'];
            }
        }

        ${$mName2} = new {$mName3}();
        $my{$mName3} = ${$mName2}->get{$mName3}( $searchKey, $page );
        $rowCount = ${$mName2}->getNum{$mName3}( $searchKey );

        $this->pageLimit = new PageLimitManager();
        $this->pageLimit->setBaseUrl( $this->createUrl('') );
        $this->pageLimit->setRowCount( $rowCount );
        $this->pageLimit->setPageShowCount( BaseMapper::DEFAULT_ROW_COUNT );
        $this->pageLimit->setPage( $page );
        $this->pageLimit->setSearchKey( $searchKey );

        $this->render('list',array(
            'searchKey' => $searchKey,
            'page' => $page,
            '{$mName2}' => $my{$mName3}
        ));
    }

    /**
     *  edit
     */
    public function actionEdit( $id )
    {
        $id = (int) $id;
        ${$mName2} = new {$mName3}();
        ${$oName2} = ${$mName2}->get{$oName3}($id);
        if(!${$oName2}) {
            Request::redirect('list');
        }

        // update
        if( Request::isPost() ) {
            $posts = Request::getPostInfo();
{foreach $vName5 as $key => $val}
{if $vName5.$key=="id"}
{elseif $vName5.$key=="properties"}
{elseif $vName5.$key=="create_date"}
{elseif $vName5.$key=="update_date"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( time() );
{elseif $fieldType.$key=="timestamp" || $fieldType.$key=="date" || $fieldType.$key=="datetime"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( strtotime($posts['{$vName2.$key}']) );
{else}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( $posts['{$vName2.$key}']{$vName2.$key|space_even} );
{/if}
{/foreach}

            $messages = ${$oName2}->validate();
            ${$oName2}->filter();
            if( $messages ) {
                SessionManager::setErrorMessages('更新失敗');
                $data['fieldsMessages'] = $messages;
                $data['{$oName2}'] = ${$oName2};
                $this->render('edit', $data );
                return;
            }
            ${$mName2}->update{$oName3}(${$oName2});
            SessionManager::setSuccessMessages('更新成功');

        }

        // edit
        $data['{$oName2}'] = ${$oName2};
        $this->render('edit',$data);
    }

    /**
     *  new
     */
    public function actionNew()
    {

        // add 
        if( Request::isPost() ) {
            $posts = Request::getPostInfo();
            ${$oName2} = new {$oName3}();
{foreach $vName5 as $key => $val}
{if $vName5.$key=="id"}
{elseif $vName5.$key=="properties"}
{elseif $vName5.$key=="create_date" || $vName5.$key=="update_date"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( time() );
{elseif $fieldType.$key=="timestamp" || $fieldType.$key=="date" || $fieldType.$key=="datetime"}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( strtotime($posts['{$vName2.$key}']) );
{else}
            ${$oName2}->set{$vName3.$key}{$vName3.$key|space_even} ( $posts['{$vName2.$key}']{$vName2.$key|space_even} );
{/if}
{/foreach}

            $messages = ${$oName2}->validate();
            ${$oName2}->filter();
            if( $messages ) {
                SessionManager::setErrorMessages('新增失敗');
                $data['fieldsMessages'] = $messages;
                $data['{$oName2}'] = ${$oName2};
                $this->render('new', $data );
                return;
            }
            ${$mName2} = new {$mName3}();
            ${$mName2}->add{$oName3}(${$oName2});
            SessionManager::setSuccessMessages('新增成功');

        }

        // new
        $data['{$oName2}'] = new {$oName3}();
        $this->render( 'new', $data );

    }

    /**
     *  myself setting
     */
    public function actionSetting()
    {
        exit;

        $blogs = new Blogs();        
        $blogId = SessionManager::getValue('blogId');
        if( !$blogId || !$blog = $blogs->getBlog($blogId) ) {
            Request::redirect('admin/');
        }

        // update setting
        if( Request::isPost() ) {
            $posts = Request::getPostInfo();
            // set ......
            // ..........
        }

        // setting
        $this->render('setting',$data);
    }

}
