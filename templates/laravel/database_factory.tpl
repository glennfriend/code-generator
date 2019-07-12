<?php

use Faker\Generator as Faker;
use App\Entities\Eloquent\{$mod->upperCamel()};
use Modules\xxxxxx\Entities\Eloquent\{$obj->upperCamel()};

$factory->define({$obj->upperCamel()}::class, function (Faker $faker)
{
    
    $attribs = <<<EOD
{
    "raw": {
        "action_type": "attempt",
        "email": "{ldelim}$faker->email{rdelim}",
        "meta": {
            "card_type": "visa",
            "processor_id": "{ldelim}$faker->randomDigit(){rdelim}"
        }
    }
}
EOD;

    // $faker->name() . '-' . $faker->lexify('?????') . '-' . date_default_timezone_get(),
    return [
{foreach $tab as $key => $field}
{if $key==='id'}
{elseif $key==='attribs'}
        '{$field.ado->name}'{$key|space_even} => $attribs,
{elseif $key==='createdAt'}
        '{$field.ado->name}'{$key|space_even} => $faker->dateTime('now', date_default_timezone_get()),
{elseif $key==='updatedAt'}
        '{$field.ado->name}'{$key|space_even} => $faker->dateTime(),
{elseif $key==='deletedAt'}
        '{$field.ado->name}'{$key|space_even} => null,
{elseif $key==='name'}
        '{$field.ado->name}'{$key|space_even} => $faker->name(),
{elseif $field.ado->type=='tinyint' || $field.ado->type=='smallint' || $field.ado->type=='mediumint' || $field.ado->type=='int'}
        '{$field.ado->name}'{$key|space_even} => $faker->randomDigit(),
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
        '{$field.ado->name}'{$key|space_even} => $faker->dateTime(),
{else}
        '{$field.ado->name}'{$key|space_even} => $faker->lexify('??????'),
{/if}
{/foreach}
    ];
});

}

// 請查 https://www.cnblogs.com/love-snow/articles/7655450.html