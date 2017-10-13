<?php

class {$mName3}Record extends CActiveRecord
{
    public static function model($className=__CLASS__)
    {
        return parent::model($className);
    }

    /**
     *  @return string the associated database table name
     */
    public function tableName()
    {
        return '{$mName5}';
    }

    /**
     *  @return array validation rules for model attributes.
     */
    public function rules()
    {
        return array(
            array('id', 'numerical', 'integerOnly'=>true, 'min'=>0 ),
            array('{foreach $vName5 as $name}{$name}{if $name@last==false}, {/if}{/foreach}','required' ),
            array('{foreach $vName5 as $name}{$name}{if $name@last==false}, {/if}{/foreach}', 'safe', 'on'=>'search' ),
            array("{foreach $vName5 as $key => $val}{if $fieldType.$key=='int' || $fieldType.$key=='tinyint' || $fieldType.$key=='smallint'}{$val}{if $val@last==false}, {/if}{/if}{/foreach}", 'numerical', 'integerOnly'=>true ),
            array('create_time, update_time', 'safe' ),  // ??
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations()
    {
        return array(
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels()
    {
        return array(
{foreach $vName3 as $key => $val}
            "{$vName5.$key}" {$vName5.$key|space_even} => "{$vName6.$key}"{if $val@last==false},{/if}

{/foreach}
        );
    }

    /**
     * Retrieves a list of models based on the current search/filter conditions.
     * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
     */
    public function search()
    {
        $criteria = new CDbCriteria;
        // 參數三: false 完全匹配, true 模糊匹配 ( like %key% )
{foreach $vName5 as $key => $val}
{if $fieldType.$key=="text"}
        $criteria->compare('{$val}',{$vName5.$key|space_even}$this->{$val},{$vName5.$key|space_even}true,  'AND' );
{else}
        $criteria->compare('{$val}',{$vName5.$key|space_even}$this->{$val},{$vName5.$key|space_even}false, 'AND' );
{/if}
{/foreach}

        //
        $criteria->addCondition("id = :id");
        $criteria->params[':id'] = 1 ;
        $criteria->addCondition('id=1','OR');                   // 這是OR條件，多個條件的時候，該條件是OR而非AND
        $criteria->addInCondition('id', array(1,2,3,4,5));      // where id IN (1,23,,4,5,);
        $criteria->addNotInCondition('id', array(1,2,3,4,5));   // 與上面正好相法，是NOT IN
        $criteria->addSearchCondition('name', '分類');          // 搜索條件，其實代表了。。where name like '%分類%'
        $criteria->addBetweenCondition('id', 1, 4);             // between 1 and 4

        // some public vars
        $criteria->select   = 'id,create_date,update_Date';     // 代表了要查詢的字段，默認select='*';
        $criteria->join     = 'xxx';                            // 連接表
        $criteria->with     = 'xxx';                            // 調用relations
        $criteria->limit    = APPLICATION_ITEMS_PER_PAGE;       // 如果小于 0 則不作處理
        $criteria->offset   = 1;                                // 兩條合并起來，則表示 limit 10 offset 1,或者代表了。limit 1,10
        $criteria->order    = 'status ASC, id DEAC' ;
        $criteria->group    = 'group 條件';
        $criteria->having   = 'having 條件 ';
        $criteria->distinct = FALSE;                            // 是否唯一查詢

        //
        return new CActiveDataProvider('{$mName1}', array(
            'criteria'=>$criteria,
        ));

    }

}

