<?php
declare(strict_types=1);

use Faker\Generator as Faker;
{if $isModule}use Modules\xxxxxx\Entities\Eloquent\{$obj->upperCamel()};
{else        }use App\Entities\Eloquent\{$obj->upperCamel()};
{/if}

$factory->define({$obj->upperCamel()}::class, function (Faker $faker)
{
    return [
{foreach $tab as $key => $field}
{if $key==='id'}
{elseif $key==='attribs'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $attribs,
{elseif $key==='createdAt'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->dateTime('now', date_default_timezone_get()),  // {$field.ado->name} 可能沒有做用
{elseif $key==='updatedAt'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->dateTime(),  // {$field.ado->name} 可能沒有做用
{elseif $key==='deletedAt'}
        '{$field.ado->name}'{$field.ado->name|space_even} => null,
{elseif $key==='name'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->name(),
{elseif $key==='firstName'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->firstName(),
{elseif $key==='lastName'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->lastName(),
{elseif $key==='uuid'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->unique()->uuid(),
{elseif $key==='email'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->safeEmail(),
{elseif $field.ado->type=='tinyint'}
        '{$field.ado->name}'{$field.ado->name|space_even} => (int) $faker->boolean(),
{elseif $field.ado->type=='smallint' || $field.ado->type=='mediumint' || $field.ado->type=='int' || $field.ado->type=='bigint'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->randomDigitNotNull(),
{elseif $field.ado->type=='double'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->randomFloat($nbMaxDecimals = NULL, $min = 0, $max = NULL),
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->dateTime(),
{elseif $field.ado->type=='text' || $field.ado->type=='mediumtext' || $field.ado->type=='longtext'}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->lexify('?????? {$field.ado->name}') . ' ' . $faker->emoji(),
{else}
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->lexify('?????? {$field.ado->name}'),
{/if}
{/foreach}
    ];
});

// example 2
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

    // 
    // $faker->lexify('?????')
    // $randomUniqueId = $faker->unique()->randomDigit;
    return [
        'attribs' => $attribs,
        'name' => $faker->name(),
        'age' => $faker->numberBetween(1, 120),
        'status' => $faker->randomElement(['enabled', 'disabled']),
        'timezone' => date_default_timezone_get(),
    ];
});

// 請查 https://github.com/fzaninotto/Faker
// 請查 https://www.cnblogs.com/love-snow/articles/7655450.html