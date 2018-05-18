<?php
declare(strict_types = 1);
namespace App\Db;

use vvh;
use Model\BaseObject;
use Model\ValueObjectExtendFetch;
{foreach from=$tab key=key item=field}
{if $key=='attribs'}
use Model\ValueObjectExtendAttribs;
{elseif $key=='properties'}
use Model\ValueObjectExtendProperties;
{elseif $key=='userId'}
use App\Db\User;
{/if}
{/foreach}

/**
 * {$obj->upperCamel()} value object
 *
{foreach from=$tab key=key item=field}
{if $key=='properties'}
 * @method        getProperty($key, $defaultValue)
 * @method void   setProperty($key, $value)
 * @method array  getProperties()
 * @method void   setProperties(array $data)
{elseif $key=='attribs'}
 * @method        getAttrib($key, $defaultValue)
 * @method void   setAttrib($key, $value)
 * @method array  getAttribs()
 * @method void   setAttribs(array $data)
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
    use ValueObjectExtendFetch;
{foreach from=$tab key=key item=field}
{if $key=='attribs'}
    use ValueObjectExtendAttribs;
{elseif $key=='properties'}
    use ValueObjectExtendProperties;
{/if}
{/foreach}

{foreach $tab as $key => $field}
{if $field.ado->type=='tinyint' && $field.ado->name=='status'}
    // {$field.name->lower('_')}
    const {$field.name->upper()}_DISABLE    = 0;
    const {$field.name->upper()}_ENABLE     = 1;
    const {$field.name->upper()}_DELETE     = 9;
{/if}
{/foreach}

    /**
     * @return array
     */
    public function attributesDefinition()
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
{elseif $key=='createdAt'}
                'filter'   => 'timestamp_or_null',
                'validate' => 'timestamp',
                'type'     => 'timestamp',
                'value'    => time(),   // microtime(true),
{elseif $key=='updatedAt' || $key=='deletedAt'}
                'filter'   => 'timestamp_or_null',
                'type'     => 'timestamp',
{elseif $key=='properties'}
                'filter'   => 'arrayval',
                'type'     => 'array',
{elseif $key=='attribs'}
                'filter'   => 'arrayval',
                'type'     => 'json',
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
{elseif $field.ado->type=='timestamp'}
                'filter'   => 'timestamp_or_null',
                'validate' => 'timestamp',
                'type'     => 'timestamp',
{elseif $field.ado->type=='datetime' || $field.ado->type=='date'}
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

    /* --------------------------------------------------------------------------------
        rewrite
    -------------------------------------------------------------------------------- */

    /* public function validate(): array
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
    } */

    /* --------------------------------------------------------------------------------
        hook
    -------------------------------------------------------------------------------- */

    // protected static function writeHook($object) { // by ModelExtendCurd
    // }

    /* --------------------------------------------------------------------------------
        extends
    -------------------------------------------------------------------------------- */



    /* --------------------------------------------------------------------------------
        lazy loading methods
    -------------------------------------------------------------------------------- */

{foreach from=$tab key=key item=field}
{if $key=='userId'}
    /**
     * fetch User
     *
     * @param bool isCacheBuffer , is storage in the object
     * @return User|null
     */
    public function fetchUser(bool $isCacheBuffer=true): ?User
    {
        $userId = $this->getUserId();
        return $this->_fetch(User::class, $userId, $isCacheBuffer);
    }
{/if}
{/foreach}

}

