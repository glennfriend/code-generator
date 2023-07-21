<?php

// code_snippet.tpl

{if $isModule}
use Modules\____\Entities\{$obj->upperCamel()};
{else}
use App\Entities\{$obj->upperCamel()};
{/if}

return new class
{
    public function attributes()
    {
        $attributes = [
{foreach $tab as $key => $field}
{if $key=="idxx"}
{elseif    strstr($field.ado->type, 'tinyint')
        || strstr($field.ado->type, 'smallint')
        || strstr($field.ado->type, 'bigint')
        || strstr($field.ado->type, 'int')
}
            '{$field.ado->name}'{$field.ado->name|space_even} => (int)    ${$obj}->{$field.ado->name},
{elseif $field.ado->type|in_array:['float', 'decimal']}
            '{$field.ado->name}'{$field.ado->name|space_even} => (float)  ${$obj}->{$field.ado->name},
{elseif $field.ado->type|in_array:['varchar']}
            '{$field.ado->name}'{$field.ado->name|space_even} => (string) ${$obj}->{$field.ado->name},
{else}
            '{$field.ado->name}'{$field.ado->name|space_even} =>          ${$obj}->{$field.ado->name},   // {$field.ado->type}
{/if}
{/foreach}

        ${$obj} = new {$obj->upperCamel()}();
{foreach $tab as $key => $field}
{if $key=="id____"}
{else}
        ${$obj}->{$field.name->lower('_')} {$field.ado->name|space_even:20} = null;
{/if}
{/foreach}

    }

    public function attributes()
    {
        $attributes = [
{foreach $tab as $key => $field}
{if     strstr($field.ado->type, 'tinyint')
        || strstr($field.ado->type, 'smallint')
        || strstr($field.ado->type, 'bigint')
        || strstr($field.ado->type, 'int')
}
            '{$field.ado->name}'{$field.ado->name|space_even} => (int)    ${$obj}->get{$field.name->upperCamel()}(),
{elseif $field.ado->type|in_array:['float', 'decimal']}
            '{$field.ado->name}'{$field.ado->name|space_even} => (float)  ${$obj}->get{$field.name->upperCamel()}(),
{elseif $field.ado->type|in_array:['varchar']}
            '{$field.ado->name}'{$field.ado->name|space_even} => (string) ${$obj}->get{$field.name->upperCamel()}(),
{else}
            '{$field.ado->name}'{$field.ado->name|space_even} =>          ${$obj}->get{$field.name->upperCamel()}(),  // {$field.ado->type}
{/if}
{/foreach}
        ];
        
        ${$obj} = new {$obj->upperCamel()}();
{foreach $tab as $key => $field}
{if $key=="id____"}
{else}
        ${$obj}->get{$field.name->upperCamel()}();
{/if}
{/foreach}
    }


}