<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Molds;
{else        }namespace App\Molds;
{/if}


use vvh;
use Cor\Mold\{ldelim}BaseObject, ValueObjectExtendFetch{rdelim};
{foreach from=$tab key=key item=field}
{if $key=='attribs'}
use Cor\Mold\ValueObjectExtendAttribs;
{elseif $key=='properties'}
use Cor\Mold\ValueObjectExtendProperties;
{elseif $key=='updatedAt'}
use Cor\Mold\ValueObjectExtendTouch;
{elseif $key=='userId'}
use App\Entities\User;
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
 * @method mixed  getAttrib($key, $defaultValue = null)
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
{elseif $key=='updatedAt'}
    use ValueObjectExtendTouch;
{/if}
{/foreach}

{foreach $tab as $key => $field}
{if $field.ado->name=='status' && $field.ado->type=='enum'}
    // {$field.name->lower('_')} ({$field.ado->type})
    const {$field.name->upper()}_ENABLE     = 'enable';
    const {$field.name->upper()}_DISABLE    = 'disable';
{elseif $field.ado->name=='status'}
    // {$field.name->lower('_')} ({$field.ado->type})
    const {$field.name->upper()}_DISABLE    = 0;
    const {$field.name->upper()}_ENABLE     = 1;
    const {$field.name->upper()}_DELETE     = 9;
{elseif $field.ado->type=='tinyint'}
    // {$field.name->lower('_')} ({$field.ado->type})
    const {$field.name->upper()}_TYPE0      = 0;
    const {$field.name->upper()}_TYPE1      = 1;
{elseif $field.ado->type=='enum'}
    // {$field.name->lower('_')} ({$field.ado->type})
    const {$field.name->upper()}_ITEM_DISABLE   = 'disable';
    const {$field.name->upper()}_ITEM_ENABLE    = 'enable';
    const {$field.name->upper()}_ITEM_DELETE    = 'delete';
{/if}
{/foreach}

    /**
     * @return array
     */
    public function attributesDefinition(): array
    {
        return [
{foreach from=$tab key=key item=field}
            '{$field.ado->name}' => [
{if $key=='id'}
                'filter'   => 'intval',
                'validate' => 'required, integer, min:0',
{elseif $key=='status' && $field.ado->type=='enum'}
                'validate' => 'required',
                'value'    => self::STATUS_ENABLE,
{elseif $key=='status'}
                'validate' => 'required, integer',
                'value'    => self::STATUS_ENABLE,
{elseif $key=='createdAt'}
                'filter'   => 'timestamp_or_null',
                'validate' => 'timestamp',
                'type'     => 'timestamp',
                'value'    => microtime(true),   // time(), microtime(true),
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
{elseif $field.ado->type=='enum'}
                'validate' => 'required, integer',
                'value'    => self::ITEM_OPTIONS, // enum
{else}
                'filter'   => '??????',
                'validate' => '??????',  // {$field.ado->type}
{/if}
            ],
{/foreach}
        ];
    }

    // --------------------------------------------------------------------------------
    //  rewrite
    // --------------------------------------------------------------------------------

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

    // --------------------------------------------------------------------------------
    //  hook
    // --------------------------------------------------------------------------------

    // protected static function writeHook($object) { // by ModelExtendCurd
    // }

    // --------------------------------------------------------------------------------
    //  extends
    // --------------------------------------------------------------------------------



    // --------------------------------------------------------------------------------
    //  lazy loading methods
    // --------------------------------------------------------------------------------

{foreach from=$tab key=key item=field}
{if $key=='userId'}
    /**
     * fetch User
     *
     * @param bool $isCacheBuffer , is storage in the object
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

