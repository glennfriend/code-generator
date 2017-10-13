<?php

/**
 * {$obj->upperCamel()} value object
 *
{foreach from=$tab key=key item=field}
{if $key=='properties'}
 * @method string getProperty($key, $defaultValue)
 * @method void   setProperty($key, $value)
 * @method array  getProperties()
 * @method void   setProperties(array $data)
{elseif $field.ado->type=='tinyint'
    || $field.ado->type=='int'
    || $field.ado->type=='smallint'
    || $field.ado->type=='bigint'
    || $field.ado->type=='float'
    || $field.ado->type=='decimal'
    || $field.ado->type=='timestamp'
    || $field.ado->type=='datetime'
    || $field.ado->type=='date'
}
 * @method int    {$field.name->get()}()
 * @method void   {$field.name->set()}($value)
{else}
 * @method string {$field.name->get()}()
 * @method void   {$field.name->set()}($value)
{/if}
{/foreach}
 */
class {$obj->upperCamel()} extends BaseObject
{
{foreach $tab as $key => $field}
{if $field.ado->type=='tinyint'}
    // {$field.name->lower('_')}
    // const {$field.name->upper('_')}_ALL       = -1;
    const {$field.name->upper('')}_DISABLE    = 0;
    const {$field.name->upper('')}_ENABLE     = 1;
    const {$field.name->upper('')}_DELETE     = 2;

{/if}
{/foreach}

    /**
     * 請依照 table 正確填寫該 field 內容
     * @return array
     */
    public static function getTableDefinition()
    {
        return [
{foreach from=$tab key=key item=field}
            '{$key}' => array(
{if $key=='properties'}
                'type'    => 'string',
                'filters' => array('arrayval'),
{elseif $field.ado->type=='tinyint' || $field.ado->type=='int' || $field.ado->type=='smallint'}
                'type'    => 'integer',
                'filters' => array('intval'),
{elseif $field.ado->type=='float'}
                'type'    => 'intval',
                'filters' => array('floatval'),
{elseif $field.ado->type=='decimal'}
                'type'    => 'string',
                'filters' => array('trim'),
{elseif $field.ado->type=='varchar' || $field.ado->type=='text' || $field.ado->type=='mediumtext'}
                'type'    => 'string',
                'filters' => array('strip_tags', 'trim'),
{elseif $field.ado->type=='char'}
                'type'    => 'string',
                'filters' => array('strip_tags'),
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
                'type'    => 'timestamp',
                'filters' => array('dateval'),
{else}
                'type'    => '??????',  // {$field.ado->type}
                'filters' => array('??????'),
{/if}
                'storage' => 'get{$tab[$key].name->upperCamel()}',
                'field'   => '{$field.ado->name}',
{if $key=='createTime' || $key=='updateTime'}
                'value'   => time(),
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
                'value'   => strtotime('2000-01-01'),
{elseif $key=='status'}
                'value'   => self::STATUS_DISABLE,
{elseif $field.ado->type=='tinyint'}
                'value'   => self::{$tab[$key].name->upper('')}_ENABLE,
{/if}
            ),
{/foreach}
        ];
    }

    // /**
    //  *  reset value
    //  */
    // public function resetValue()
    // {
    //     parent::resetValue();
    // }

    /**
     * validate
     * @return messages array
     */
    public function validate()
    {
        $messages = array();

{foreach $tab as $key => $field}
{if $key=='key'}
        // 予許空值, 但是不予許錯誤的格式
        if ($this->getKey() && !preg_match('/^[0-9a-z_\-]+$/is', $this->getKey())) {
            $messages['{$key}'] = '該欄位必須是英文或數字, 不可以使用特殊符號';
        }

{elseif $key=='email'}
        // email
        $result = filter_var($this->getEmail(), FILTER_VALIDATE_EMAIL);
        if (!$result) {
          //$messages['{$key}'] = 'Email 格式不正確';
            $messages['{$key}'] = 'The Email is validation fails.';
        }

{elseif $key=='url' || $key=='link'}
        // url
        $result = filter_var($this->getUrl(), FILTER_VALIDATE_URL);
        if (!$result) {
          //$messages['{$key}'] = '網址格式不正確';
            $messages['{$key}'] = 'The field is validation fails';
        }

{elseif $key=='properties'}
{elseif $field.ado->type=='text'}
{elseif $key=='name' || $key=='title' || $key=='topic'}
        if (!$this->{$field.name->get()}()) {
          //$messages['{$key}'] = '該欄位必填';
            $messages['{$key}'] = 'The field is required.';
        }
        elseif (!TextValidator::validateNormalTopic($this->{$field.name->get()}())) {
          //$messages['{$key}'] = '該欄位驗証失敗, 請檢查是否有使用到特殊字元';
            $messages['{$key}'] = 'The field is validation fails.';
        }

{elseif $field.ado->type=='varchar'}
        if (!$this->{$field.name->get()}()) {
          //$messages['{$key}'] = '該欄位必填';
            $messages['{$key}'] = 'The field is required.';
        }

{elseif $field.ado->type=='tinyint'}
        // choose value
        $result = false;
        foreach (cc('attribList', $this, '{$key}') as $name => $value) {
            if ($this->{$field.name->get()}() === $value) {
                $result = true;
                break;
            }
        }
        if (!$result) {
            $messages['{$key}'] = '{$key} incorrect';
        }

{elseif $field.ado->type=='int' || $field.ado->type=='smallint'}
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date' }
        // // timestamp, datetime, date
        // if ($this->{$field.name->get()}() < -28800) {
        //     $messages['{$key}'] = 'The Date incorrect';
        // }

{elseif $field.ado->type=='date' || $field.ado->type=='datetime'}
{else}
{/if}
{/foreach}
        return $messages;
    }

    /* ------------------------------------------------------------------------------------------------------------------------
        basic method rewrite or extends
    ------------------------------------------------------------------------------------------------------------------------ */

    /**
     *  Disabled methods
     *  @return array()
     */
    public static function getDisabledMethods()
    {
        // return ['setIpn','setCustomSearch'];
        return [];
    }

    /* ------------------------------------------------------------------------------------------------------------------------
        extends
    ------------------------------------------------------------------------------------------------------------------------ */



    /* ------------------------------------------------------------------------------------------------------------------------
        lazy loading methods
    ------------------------------------------------------------------------------------------------------------------------ */

    /**
     *  get user object
     *  物件快取預設為 false -> "non-cache", 需要時才使用
     *
     *  @param isCacheBuffer , is store object
     *  @return object or null
     */
    public function getUser($isCacheBuffer=false)
    {
        if (!$isCacheBuffer) {
            $this->_user = null;
        }
        if (isset($this->_user)) {
            return $this->_user;
        }

        $userId = $this->getUserId();
        if (!$userId) {
            return null;
        }
        $users = new Users();
        $user = $users->getUser($userId);

        if ($isCacheBuffer) {
            $this->_user = $user;
        }
        return $user;
    }

}

