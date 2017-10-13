
<script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/js/pages/Admin{$oName3}_list.js"></script>

<?php include $this->getLayoutFile('block_top_messages'); ?>
<form id="searchForm" class="searchForm1" method="post" action="">

    <fieldset>
        <legend>搜尋</legend>

        <div class="field">
            <label for="搜尋關鍵字">搜尋關鍵字</label>
            <div class="show">
                <input type="text" name="searchKey" value="<?php echo $searchKey; ?>" size="30" />
            </div>
            <div class="info"></div>
        </div>

        <div class="field">
            <label for="show">&amp;nbsp;</label>
            <div class="show">
                <input class="submit" type="submit" value="顯示" />
            </div>
            <div class="info"></div>
        </div>

    </fieldset>

</form>
<br style="clear:both" />

<div class="block">
              <a href="<?php echo $this->url->get('admin{$oName3}','new',$user); ?>" class="button1">建立</a>
    <a href="#" situs="<?php echo $this->url->get('admin{$oName3}','new',$user); ?>" class="button1 openWorkWin">建立(new window)</a>
</div>


<form id="listForm" method="post" action="<?php echo $this->createUrl('admin{$oName3}/delete'); ?>">

    <table class="table1" cellspacing="0">
        <tr>
            <th class="nobg">
                <input class="checkbox" type="checkbox" id="chooseItemsAll" value="1" />
            </th>
{foreach $vName5 as $key => $val}
{if $val=='id'}
            <th> id                     </th>
{elseif $val=="name"}
            <th> 姓名                   </th>
{elseif $val=="email"}
            <th> 電子郵件               </th>
{elseif $val=="create_date"}
            <th> 建立日期               </th>
{elseif $val=="update_date"}
            <th> 最後修改日期           </th>
{elseif $val=="status"}
            <th> 狀態                   </th>
{elseif $val=='properties'}
{else}
            <th> {$val}{$val|space_even} </th>
{/if}
{/foreach}
            <th> 管理 </th>
        </tr>
        <?php
            foreach( ${$mName2} as ${$oName2} ) {
                echo '<tr>';
                echo '    <th><input class="checkbox" type="checkbox" name="chooseItems[]" value="'. ${$oName2}->getId() .'"></th>';
{foreach $vName5 as $key => $val}
{if $val=='id'}
                echo     '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
{elseif $val=='properties'}
{elseif $fieldType.$key=='tinyint'}
                echo     '<td>'. ${$oName2}->trByStatus('{$vName2.$key}', ${$oName2}->get{$vName3.$key}() ) .'</td>';
{elseif $fieldType.$key=='int'}
                echo     '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
{elseif $fieldType.$key=='varchar' || $fieldType.$key=='text'}
                echo     '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='date' || $fieldType.$key=='datetime'}
                echo     '<td>'. ${$oName2}->get{$vName3.$key}ByFormat()     .'</td>';
{else}
              //echo     '<td>'. ${$oName2}->get{$vName3.$key}(){$vName3.$key|space_even} .'</td>';
{/if}
{/foreach}
                echo     '<td>';
                echo         '<a href="'. $this->url->get('admin{$oName3}','edit',${$oName2})     .'">編輯</a> ';
                echo         '<a href="'. $this->url->get('admin{$oName3}','delete',${$oName2})   .'">刪除</a> ';
                echo     '</td>';
                echo '</tr>';
            }
        ?>
    </table>

</form>

