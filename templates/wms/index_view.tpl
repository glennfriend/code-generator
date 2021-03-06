<?php

    $findUri   = $this->pageLimit->generateUri(1);

    $findKeys = json_encode($this->pageLimit->getParam('findKeys'));
    if ( $findKeys === 'null' ) {
        $findKeys = '{}';
    }

    // get findOptions
    $getFindOptions = function()
    {
        return json_encode(array(
            'status' => cc('attribList', new {$obj->upperCamel()}(), 'status'),
            'type' => array(
                '0' => 'default type',
                '1' => 'type A',
                '2' => 'type B',
            ),
        ));
    };


    $newLink    = $this->createUrl('new');
  //$newLink    = $this->createUrl('new', array('parentId'=>$id) );
    $deleteLink = $this->createUrl('delete');

    // CClientScript::POS_HEAD, POS_BEGIN, POS_END
    Yii::app()->clientScript->registerScriptFile( UrlManager::module("/模組名稱/js/home_index.js"), CClientScript::POS_HEAD );
?>
    <script type="text/javascript" charset="utf-8">
        "use strict";
        $(function(){
            app.init.qtip();
            aid.event.checkboxAll('#chooseItemsAll');

            // field sort
            var findUri = '<?php echo $findUri; ?>';
            aid.ui.fieldSort('#table-index th', findUri);

            // custom find
            aid.ui.customFind( <?php echo $findKeys; ?>, <?php echo $getFindOptions(); ?> );

            // find
            $('#form-find-submit').on('click',function(){
                $('#form-index')
                    .attr('action', '<?php echo $this->createUrl('/orderItem/home/index'); ?>')
                    .submit();
            });

            // reset find
            $('#form-find-reset').on('click',function(e){
                $('input[name^=findKeys]').val('');
                $('#form-find-submit').click();
            });

            // find field "ENTER" event
            $('input[name^=findKeys]').on('keydown',function(e){
                if ( e.keyCode==13 ) {
                    $('#form-find-submit').click();
                }
            });

            // delete
            $('#form-delete-submit').on('click',function(){
                $('#form-index')
                    .attr('action', '<?php echo $deleteLink; ?>')
                    .submit();
            });

        });
    </script>

    <form id="form-index" class="form-inline" method="post">

        <input type="hidden" name="page"      value="<?php echo $this->pageLimit->getPage(); ?>" />
        <input type="hidden" name="sortField" value="<?php echo $this->pageLimit->getParam('sortField'); ?>" />
        <input type="hidden" name="sortBy"    value="<?php echo $this->pageLimit->getParam('sortBy');    ?>" />

        <div class="row">
            <div class="col-md-12">

                <div class="form-group">
                    <select class="form-control" name="status">
                    <?php
                        echo "<option value='". {$obj->upperCamel()}::STATUS_ALL ."' >". lgg('dbobject_{$obj->lower()}_status_all') ."</option>";
                        $list = cc('attribList', new {$obj->upperCamel()}(), 'status');
                        foreach ( $list as $name => $value ) {
                            $selected = ($status==$value) ? ' selected="selected" ' : '';
                            echo "<option value='{ldelim}$value{rdelim}' {ldelim}$selected{rdelim}>";
                            echo    lgg('dbobject_{$obj->lower()}_'. strtolower($name)) .' '. lgg('dbobject_{$obj->lower()}_status');
                            echo "</option>";
                        }
                    ?>
                    </select>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="search keyword" name="searchKey" value="echo $searchKey" />
                        <span class="input-group-btn">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </span>
                    </div>
                </div>

                <div class="pull-right">
                    <a href="#" class="btn btn-default">Add</a>
                    <button class="btn btn-primary">Export All CSV</button>
                    <button id="form-find-submit" type="button" class="btn btn-primary">Search</button>
                    <?php echo cc('displayPageInfo',  $this->pageLimit ); ?>
                </div>

            </div>
        </div>
        <p></p>



        <table id="table-index" class="table table-striped table-condensed table-bordered">
            <thead>
                <tr>
                    <th style="width:15px;"><input class="checkbox" type="checkbox" id="chooseItemsAll" value="1" /></th>
{foreach $tab as $key => $field}
{if $key=='id'}
                    <th style="width:55px;">id</th>
{elseif $key=='properties'}
{elseif $key=='attribs'}
{else}
                    <th><?php echo lgg('dbobject_{$obj->lower()}_{$key|lowerChar}');{$key|lowerChar|space_even} ?></th>
{/if}
{/foreach}
                    <th>管理</th>
                </tr>
            </thead>
            <thead>
                <tr>
                    <th style="width:15px;"><input class="checkbox" type="checkbox" id="chooseItemsAll" value="1" /></th>
{foreach $tab as $key => $field}
{if $key=='id'}
                    <th class="js_field_{$field.name}" style="width:55px;">id</th>
{elseif $key=='properties'}
{elseif $key=='attribs'}
{else}
                    <th class="js_field_{$field.name}"{$field.name|space_even}>{$field.name->upperCamel(' ')}{$field.name->upperCamel(' ')|space_even}</th>
{/if}
{/foreach}
                    <th>管理</th>
                </tr>
                <tr>
{foreach $tab as $key => $field}
{if $key=='id'}
                    <td><input type="text" class="form-control input-sm" name="findKeys[id]"                   /></td>
{elseif $key=='properties'}
{elseif $key=='attribs'}
{else}
                    <td><input type="text" class="form-control input-sm" name="findKeys[{$key}]" {$key|space_even}/></td>
{/if}
{/foreach}
                    <td></td>
                </tr>
            </thead>
            <tbody>
            <?php foreach ( ${$mod} as ${$obj} ) {
                $showLink      = $this->createUrl('{$obj}/show', array('{$obj}Id'=>${$obj}->getId()));
                $editLink      = $this->createUrl('{$obj}/edit', array('{$obj}Id'=>${$obj}->getId()));
                $nextLayerLink = $this->createUrl('????????/index', array('{$obj}Id'=>${$obj}->getId()));

                $view = array();
{foreach from=$tab key=key item=field}
{if $key=='properties'}
{elseif $key=='attribs'}
{elseif $field.ado->type=='tinyint'}
                $view['{$key}']{$key|space_even} = cc('attribLgg', ${$obj}, '{$key}', ${$obj}->{$key|camelGet}() )
{elseif $field.ado->type=='int'}
                $view['{$key}']{$key|space_even} = ${$obj}->{$key|camelGet}();
{elseif $field.ado->type=='varchar' || $field.ado->type=='char' || $field.ado->type=='text'}
                $view['{$key}']{$key|space_even} = escape( ${$obj}->{$key|camelGet}() );
{elseif $field.ado->type=='timestamp' || $field.ado->type=='date' || $field.ado->type=='datetime'}
                $view['{$key}']{$key|space_even} = cc('date', ${$obj}->{$key|camelGet}() );
{else}
              //$view['{$key}']{$key|space_even} = ${$obj}->{$key|camelGet}();
{/if}
{/foreach}

                echo <<<EOD
                    <tr>
                        <th><input class="checkbox" type="checkbox" name="chooseItems[]" value="{ldelim}$view['id']{rdelim}"></th>
{foreach from=$tab key=key item=field}
{if $key=='id'}
                        <td><a href="{ldelim}$showLink{rdelim}"><div class="fam-application-home"></div>{ldelim}$view['{$key}']{rdelim}</a></td>
{elseif $key=='properties'}
{elseif $key=='attribs'}
{elseif $field.ado->type=='tinyint'}
                        <td>{ldelim}$view['{$key}']{rdelim}</td>
{elseif $field.ado->type=='int'}
                        <td>{ldelim}$view['{$key}']{rdelim}</td>
{elseif $field.ado->type=='varchar' || $field.ado->type=='text'}
                        <td>{ldelim}$view['{$key}']{rdelim}</td>
{elseif $field.ado->type=='timestamp' || $field.ado->type=='date' || $field.ado->type=='datetime'}
                        <td>{ldelim}$view['{$key}']{rdelim}</td>
{else}
                      //<td>{ldelim}$view['{$key}']{rdelim}</td>
{/if}
{/foreach}
                        <td>
                            <a href="{ldelim}$editLink{rdelim}"     ><div class="fam-pencil-add"      ></div>編輯</a>
                            <a href="{ldelim}$nextLayerLink{rdelim}"><div class="fam-application-home"></div>列表</a>
                        </td>
                    </tr>
EOD;

            } ?>
            </tbody>
            <tfoot>
                <tr>
                    <th colspan="5">
                        <div class="pull-left">
                            <div class="input-group">
                                <span class="input-group-addon">Modify Country</span>
                                <input type="text" class="form-control" placeholder="EX. TW">
                            </div>
                        </div>
                        <div class="pull-right">
                            <button class="btn btn-primary">Export selected CSV</button>
                            <button id="form-update-submit"class="btn btn-primary">Update</button>
                            <button id="form-delete-submit" class="btn btn-danger">Delete</button>
                        </div>
                    </th>
                </tr>
            </tfoot>
        </table>

    </form>

    <?php echo cc('displayPageLimit', $this->pageLimit ); ?>
