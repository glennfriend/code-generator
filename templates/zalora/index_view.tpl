<?php
    $newLink    = $this->createUrl('new');
  //$newLink    = $this->createUrl('new', array('parentId'=>$id) );
    $deleteLink = $this->createUrl('delete');

    Yii::app()->clientScript->registerScriptFile( UrlManager::js("/js/modules/模組名稱/控制器名稱_index.js") );

?>

<section>

    <div class="row">
        <div class="span9">
            <form name="form-search" id="form-search" class="form-inline" method="get">
                <input type="text" class="input" placeholder="請輸入關鍵字" name="searchKey" value="<?php echo $searchKey; ?>" />
                <select name="status">
                <?php
                    echo "<option value='". {$oName3}::STATUS_ALL ."' >".  lgg('dbobject_{$oName1}_status_all') ."</option>";
                    $list = cc('attribList', new {$oName3}, 'status');
                    foreach ( $list as $name => $value ) {
                        $selected = '';
                        if ( $status == $value ) {
                            $selected = ' selected="selected" ';
                        }
                        echo "<option value='{ldelim}$value{rdelim}' {ldelim}$selected{rdelim}>";
                        echo    lgg('dbobject_{$oName1}_'. strtolower($name)) ." ". lgg('dbobject_{$oName1}_status');
                        echo "</option>";
                    }
                ?>
                </select>
                <button type="submit" class="btn btn-primary">搜尋</button>
            </form>
        </div>
        <div class="span3" style="text-align:right">
            <h2>Index</h2>
        </div>
    </div>

    <form name="form-index" id="form-index" method="post" action="<?php echo $deleteLink; ?>">

        <table id="table-index" class="table table-bordered table-striped table-condensed">
            <thead>
                <tr>
                    <th style="width:15px;"><input class="checkbox" type="checkbox" id="chooseItemsAll" value="1" /></th>
{foreach $vName5 as $key => $val}
{if $val=='id'}
                    <th style="width:55px;">id</th>
{elseif $val=='properties'}
{else}
                    <th><?php echo lgg('dbobject_{$oName5}_{$val}');{$val|space_even} ?></th>
{/if}
{/foreach}
                    <th>管理</th>
                </tr>
            </thead>
            <tbody>
            <?php foreach ( ${$mName2} as ${$oName2} ) {
                $showLink      = $this->createUrl('{$oName2}/show', array('{$oName2}Id'=>${$oName2}->getId()));
                $editLink      = $this->createUrl('{$oName2}/edit', array('{$oName2}Id'=>${$oName2}->getId()));
                $nextLayerLink = $this->createUrl('????????/index', array('{$oName2}Id'=>${$oName2}->getId()));
                echo '<tr>';
                echo    '<th><input class="checkbox" type="checkbox" name="chooseItems[]" value="'. ${$oName2}->getId() .'"></th>';
{foreach $vName5 as $key => $val}
{if $val=='id'}
                echo    '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
                echo    '<td>';
                echo        '<a href="'. $showLink .'"><div class="fam-application-home"></div>'. ${$oName2}->get{$vName3.$key}() .'</a>';
                echo    '</td>';
{elseif $val=='properties'}
{elseif $fieldType.$key=='tinyint'}
                echo    '<td>'. cc('attribLgg' ${$oName2}, '{$vName5.$key}', ${$oName2}->get{$vName3.$key}() ) .'</td>';
{elseif $fieldType.$key=='int'}
                echo    '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
{elseif $fieldType.$key=='varchar' || $fieldType.$key=='text'}
                echo    '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='date' || $fieldType.$key=='datetime'}
                echo    '<td>'. cc('date',${$oName2}->get{$vName3.$key}()) .'</td>';
{else}
              //echo     '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
{/if}
{/foreach}
                echo    '<td>';
                echo        '<a href="'. $editLink      .'"><div class="fam-pencil-add"></div>編輯</a> ';
                echo        '<a href="'. $nextLayerLink .'"><div class="fam-application-home"></div>列表</a> ';
                echo    '</td>';
                echo '</tr>';
            } ?>
            </tbody>
            <tfoot>
                <tr>
                    <th colspan="5">
                        <div style="float:left">
                            <a href="<?php echo $newLink; ?>" class="btn">New</a>
                        </div>
                        <div style="float:right">
                            <?php
                                if ($this->pageLimit) {
                                    echo $this->pageLimit->getRowCount() .' Record , ';
                                    echo $this->pageLimit->getPage() .'/'. $this->pageLimit->getTotalPage() .' Page ';
                                    echo '<input type="hidden" name="page" value="'. $this->pageLimit->getPage() .'" />';
                                }
                            ?>
                            <button class="btn btn-danger">Delete</button>
                        </div>
                    </th>
                </tr>
            </tfoot>
        </table>

        <div class="row show-grid">
            <div class="span12">
                <div class="pagination">
                <?php
                    if ($this->pageLimit) {
                        echo $this->pageLimit->render();
                    }
                ?>
                </div>
            </div>
        </div>

    </form>

</section>
