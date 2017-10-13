<?php

/**
 *
 */
class {$oName3}
{ldelim}

{foreach $vName5 as $key => $val}
{if $fieldType.$key=='tinyint'}
    CONST {$vName7.$key}_ALL        = -1;
    CONST {$vName7.$key}_CLOSE      = 0;
    CONST {$vName7.$key}_OPEN       = 1;
    CONST {$vName7.$key}_DELETE     = 9;

{else}
{/if}
{/foreach}

{foreach from=$vName2 item=name}
    protected $_{$name};
{/foreach}

    /**
     *  construct
     */
    public function __construct()
    {
        $this->resetValue();
    }

    /**
     *  讀取資料表而產生, 請視同cache, 任何情況下皆不可更動該產生的內容
     *  @return array()
     */
    public static function getTableDefinition()
    {ldelim}
        return array(
{foreach from=$status key=key item=field}
            '{$key}' => array(
                'name'           => '{$field->name}',
                'type'           => '{$field->type}',
                'length'         => {$field->max_length},
{if $field->unsigned}
                'unsigned'       => TRUE,
{else}
                'unsigned'       => FALSE,
{/if}
{if $field->primary_key}
                'primary'        => TRUE,
{else}
                'primary'        => FALSE,
{/if}
{if $field->not_null}
                'notNull'        => TRUE,
{else}
                'notNull'        => FALSE,
{/if}
{if $field->has_default}
                'defaultValue'   => '{$field->default_value}',
{else}
                'defaultValue'   => NULL,
{/if}
{if $field->auto_increment}
                'autoIncrement'  => TRUE,
{else}
                'autoIncrement'  => FALSE,
{/if}
            ),
{/foreach}
        );
    {rdelim}

    /**
     *  經資料表傳至程式中時所對應的 method 資訊
     *  @return array()
     */
    public static function getTableFields()
    {ldelim}
        return array(
{foreach $vName3 as $key => $val}
{if $fieldType.$key=='timestamp' || $fieldType.$key=='datetime' || $fieldType.$key=='date'}
            "{$vName5.$key}" {$vName5.$key|space_even} => "get{$vName3.$key}ByDb"{if $val@last==false},{/if}
{else}
            "{$vName5.$key}" {$vName5.$key|space_even} => "get{$vName3.$key}"{if $val@last==false},{/if}
{/if}

{/foreach}
        );
    {rdelim}

    /**
     *  reset to default value model
     *  @return array()
     */
    public function resetValue() {ldelim}
        $this->__sleep();
{foreach $vName5 as $key => $val}
{if $val=='id'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( 0 );
{elseif $val=='status'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( self::{$vName7.$key}_OPEN );
{elseif $val=='properties'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( array() );
{elseif $status.$val->type=='tinyint'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( self::{$vName7.$key}_?????? );
{elseif $fieldType.$key=='int' || $status.$val->type=='smallint'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( 0 );
{elseif $fieldType.$key=='varchar' || $status.$val->type=='text'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( NULL );
{elseif $val=='properties'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( time() );
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='datetime' || $fieldType.$key=='date'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( strtotime('1980-01-01') );
{else}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( ?????? );
{/if}
{/foreach}
    {rdelim}

    /**
     *  validate
     *  @return messages array()
     */
    public function validate()
    {ldelim}
        $messages = array();

{foreach $vName5 as $key => $val}
{if $val=='key'}
        // 予許空值, 但是不予許錯誤的格式
        if ( $this->getKey() && !preg_match('/^[0-9a-z_\-]+$/is', $this->getKey() ) ) {
            $messages['{$val}'] = '該欄位必須是英文或數字, 不可以使用特殊符號';
        }

{elseif $val=='email'}
        // email
        $result = filter_var( $this->getEmail(), FILTER_VALIDATE_EMAIL );
        if (!$result) {
          //$messages['{$val}'] = 'Email 格式不正確';
            $messages['{$val}'] = 'The field is validation fails.';
        }

{elseif $val=='url' || $val=='link'}
        // url
        $result = filter_var( $this->getUrl(), FILTER_VALIDATE_URL );
        if (!$result) {
          //$messages['{$val}'] = '網址格式不正確';
            $messages['{$val}'] = 'The field is validation fails';

{elseif $fieldType.$key=='text'}
{elseif $val=='name' || $val=='title' || $val=='topic'}
        if ( !$this->get{$vName3.$key}() ) {
          //$messages['{$val}'] = '該欄位必填';
            $messages['{$val}'] = 'The field is required.';
        }
        elseif ( !TextValidator::validateNormalTopic( $this->get{$vName3.$key}() ) ) {
          //$messages['{$val}'] = '該欄位驗証失敗, 請檢查是否有使用到特殊字元';
            $messages['{$val}'] = 'The field is validation fails.';
        }

{elseif $fieldType.$key=='varchar'}
        if ( !$this->get{$vName3.$key}() ) {
          //$messages['{$val}'] = '該欄位必填';
            $messages['{$val}'] = 'The field is required.';
        }

{elseif $fieldType.$key=='tinyint'}
        // choose value
        $result = false;
        foreach ( cc('attribList', $this, '{$val}') as $name => $value ) {
            if ( $this->get{$vName3.$key}()==$value ) {
                $result = true;
                break;
            }
        }
        if (!$result) {
            $messages['{$val}'] = '{$val} incorrect';
        }

{elseif $val=='properties'}
{elseif $fieldType.$key=='int' || $fieldType.$key=='smallint'}
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='datetime' || $fieldType.$key=='date' }
        // timestamp, datetime, date
        // if ( $this->get{$vName3.$key}() < -28800 ) {
        //     $messages['{$vName2.$key}'] = 'The Date incorrect';
        // }

{elseif $fieldType.$key=='date' || $fieldType.$key=='datetime'}
{else}
{/if}
{/foreach}
        return $messages;
    {rdelim}

    /**
     *  filter model data
     */
    public function filter()
    {ldelim}
{foreach $vName5 as $key => $val}
{if $val=='properties'}
{elseif $fieldType.$key=='int' || $status.$val->type=='tinyint' || $status.$val->type=='smallint'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( (int) $this->get{$vName3.$key}() );
{elseif $fieldType.$key=='varchar' || $status.$val->type=='text'}
        $this->set{$vName3.$key}{$vName3.$key|space_even} ( trim(strip_tags( $this->get{$vName3.$key}(){$vName3.$key|space_even} )) );
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='datetime' || $fieldType.$key=='date' }
{else}
      //$this->set{$vName3.$key}{$vName3.$key|space_even} ();
{/if}
{/foreach}
    {rdelim}

    /* ------------------------------------------------------------------------------------------------------------------------
        basic method
    ------------------------------------------------------------------------------------------------------------------------ */

{foreach $vName5 as $key => $val}
{if $vName5.$key=='properties'}
    /**
     *  set {$vName2.$key}
     *  @param array
     */
    public function setProperties($properties)
    {
        if ( is_array($properties) ) {
            $this->_properties = $properties;
        }
        else {
            $this->_properties = array();
        }
    }
    /**
     *  get {$vName2.$key}
     *  @return array;
     */
    public function getProperties()
    {
        return $this->_properties;
    }
    /**
     *  set property
     *  @param string
     *  @param any
     */
    public function setProperty($key, $value)
    {
        $this->_properties[$key] = $value;
    }
    /**
     *  get property
     *  @param string
     */
    public function getProperty($key)
    {
        if ( !isset($this->_properties[$key]) ) {
            return null;
        }
        return $this->_properties[$key];
    }
{* elseif $vName5.$key=='create_date' *}
{* elseif $vName5.$key=='update_date' *}
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='date' || $fieldType.$key=='datetime'}
    /**
     *  set {$vName2.$key}
     *  @param int , date int
     */
    function set{$vName3.$key}($int)
    {
        $this->_{$vName2.$key} = (int) $int;
    }
    /**
     *  get {$vName2.$key}
     *  @return int
     */
    function get{$vName3.$key}()
    {
        if ( !$this->_{$vName2.$key} ) {
            $this->_{$vName2.$key} = time();
        }
        return $this->_{$vName2.$key};
    }
    /**
     *  convert object-value to database
     *  依照資料表欄位的格式不同, 謂給所需的格式
     *  @return string
     */
    function get{$vName3.$key}ByDb()
    {
        // "{$fieldType.$key}"
{if $fieldType.$key=='date'}
        return date("Y-m-d",$this->get{$vName3.$key}());
{else}
        return date("Y-m-d H:i:s",$this->get{$vName3.$key}());
{/if}
    }
{elseif $fieldType.$key=='int' || $fieldType.$key=='tinyint' || $fieldType.$key=='smallint'}
    /**
     *  get {$vName3.$key}
     *  @return int
     */
    public function get{$vName3.$key}()
    {ldelim}
        return $this->_{$vName2.$key};
    {rdelim}
    /**
     *  set {$vName3.$key}
     */
    public function set{$vName3.$key}( ${$vName2.$key} )
    {ldelim}
        $this->_{$vName2.$key} = (int) ${$vName2.$key};
    {rdelim}
{elseif $fieldType.$key=='float'}
    /**
     *  get {$vName3.$key}
     *  @return float
     */
    public function get{$vName3.$key}()
    {ldelim}
        return $this->_{$vName2.$key};
    {rdelim}
    /**
     *  set {$vName3.$key}
     */
    public function set{$vName3.$key}( ${$vName2.$key} )
    {ldelim}
        $this->_{$vName2.$key} = (float) ${$vName2.$key};
    {rdelim}
{else}
    /**
     *  get {$vName3.$key}
     *  @return string
     */
    public function get{$vName3.$key}()
    {ldelim}
        return $this->_{$vName2.$key};
    {rdelim}
    /**
     *  set {$vName3.$key}
     */
    public function set{$vName3.$key}( ${$vName2.$key} )
    {ldelim}
        $this->_{$vName2.$key} = trim(${$vName2.$key});
    {rdelim}
{/if}

{/foreach}

    /* ------------------------------------------------------------------------------------------------------------------------
        extends
    ------------------------------------------------------------------------------------------------------------------------ */
    /**
     *  clear extends information
     */
    public function __sleep()
    {ldelim}
        $this->_user = null;
        return array_keys(get_object_vars($this));
    {rdelim}

    /**
     *  get user dbobject
     *  @param isSave , is store object
     *  @return object or null
     */
    public function getUser( $isSave=true )
    {ldelim}

        $userId = (int) $this->_userId;
        if ( !$userId ) {
            return null;
        }

        if ( !$isSave ) {ldelim}
            $this->_user = null;
        {rdelim}
        if ( $this->_user ) {ldelim}
            return $this->_user;
        {rdelim}

        $users = new Users();
        $user = $users->getUser( $this->getUserId() );

        if ( $isSave ) {ldelim}
            $this->_user = $user;
        {rdelim}
        return $user;
    {rdelim}

{rdelim}

