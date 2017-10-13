<?php
declare(strict_types = 1);
namespace App\Db;
use App\Db\Base\BaseObject;
use App\Db\Base\ValueObjectExtendProperties;
use App\Db\Base\ValueObjectExtendFetch;
use vvh;

/**
 * {$obj->upperCamel()} value object
 *
{foreach from=$tab key=key item=field}
{if $field.ado->type=='tinyint'
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
    use ValueObjectExtendProperties;
    use ValueObjectExtendFetch;

{foreach $tab as $key => $field}
{if $field.ado->type=='tinyint'}
{if $field.ado->name=='status'}
    // {$field.name->lower('_')} (語系檔案於 resources/lang/en/value_object.php)
    const {$field.name->upper()}_DISABLE    = 0;
    const {$field.name->upper()}_ENABLE     = 1;
    const {$field.name->upper()}_DELETE     = 9;
    {else}
    // {$field.name->lower('_')}
    const {$field.name->upper()}_DISABLE    = 0;
    const {$field.name->upper()}_ENABLE     = 1;
    const {$field.name->upper()}_DELETE     = 9;
    {/if}

{/if}
{/foreach}
    /**
     *  @return array()
     */
    public static function attributesDefinition()
    {
        return [
{foreach from=$tab key=key item=field}
            '{$field.ado->name}' => [
{if $key=='id'}
                'filter'   => 'intval',
                'validate' => 'required, integer, min:0',
{elseif $key=='status'}
                'validate' => 'required, integer',
                'value'    => self::STATUS_DISABLE,
{elseif $key=='createAt' || $key=='updateAt'}
                'filter'   => 'dateval',
                'validate' => 'timestamp',
                'type'     => 'timestamp',
                'value'    => time(),
{elseif $key=='properties'}
                'filter'   => 'arrayval',
                'type'     => 'array',
{elseif $field.ado->type=='tinyint'}
                'filter'   => 'intval',
                'value'    => self::{$tab[$key].name->upper('_')}_ENABLE,
{elseif $field.ado->type=='int' || $field.ado->type=='smallint' || $field.ado->type=='bigint'}
                'filter'   => 'intval',
{elseif $field.ado->type=='float'}
                'filter'   => 'floatval',
{elseif $field.ado->type=='decimal'}
                'filter'   => 'trim',
                'validate' => 'required',
{elseif $field.ado->type=='varchar' || $field.ado->type=='text' || $field.ado->type=='mediumtext'}
                'filter'   => 'strip_tags, trim',
{elseif $field.ado->type=='char'}
                'filter'   => 'strip_tags',
                'validate' => 'required',
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
                'filter'   => 'dateval',
                'validate' => 'timestamp',
                'type'     => 'timestamp',
                'value'    => strtotime('2000-01-01'),
{else}
                'filter'   => '??????',
                'validate' => '??????',  // {$field.ado->type}
{/if}
            ],
{/foreach}
        ];
    }

    /* ------------------------------------------------------------------------------------------------------------------------
        rewrite
    ------------------------------------------------------------------------------------------------------------------------ */

    /*
    public function resetValue()
    {
        parent::resetValue();
    }
    */

    /*
    public function validate(): array
    {
        $errors = parent::validate();
        $errors = $this->validateStatus($errors);
        return $errors;
    }

    protected function validateStatus(array $errors): array
    {
        $result = in_array(
            $this->getStatus(),
            vvh::attribList($this, 'status')
        );

        if (! $result) {
            $errors['status'] = [];
            $errors['status']['message'] = 'Scope validation error';
        }

        return $errors;
    }
    */

    /* ------------------------------------------------------------------------------------------------------------------------
        hook
    ------------------------------------------------------------------------------------------------------------------------ */

    // protected static function writeHook($object)

    /* ------------------------------------------------------------------------------------------------------------------------
        extends
    ------------------------------------------------------------------------------------------------------------------------ */



    /* ------------------------------------------------------------------------------------------------------------------------
        lazy loading methods
    ------------------------------------------------------------------------------------------------------------------------ */

    /**
     *  fetch User
     *
     *  @param isCacheBuffer , is store object
     *  @return User|null
     */
    public function fetchUser($isCacheBuffer=true): ?User
    {
        $userId = $this->getUserId();
        return $this->_fetch(\App\Db\User::class, $userId, $isCacheBuffer);
    }


}

