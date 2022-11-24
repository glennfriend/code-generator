<?php
declare(strict_types=1);

// 測試的時候改用 其它目錄 才成功, 同一個目錄沒有成功
//        Modules\{$obj->upperCamel()}\Database\NewFactories;
namespace Modules\{$obj->upperCamel()}\Database\Factories;


use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;

class {$obj->upperCamel()}Factory extends Factory
{
    protected $model = {$obj->upperCamel()}::class;

    public function definition(): array
    {
        return [
{foreach $tab as $key => $field}
{if $key==='id'}
{elseif $key==='attribs'}
            '{$field.ado->name}'{$field.ado->name|space_even} => $attribs,
{elseif $key==='createdAt'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->dateTime('now', date_default_timezone_get()),  // {$field.ado->name} 可能沒有做用
{elseif $key==='updatedAt'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->dateTime(),  // {$field.ado->name} 可能沒有做用
{elseif $key==='deletedAt'}
            '{$field.ado->name}'{$field.ado->name|space_even} => null,
{elseif $key==='name'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->name(),    // this->faker->word()
{elseif $key==='firstName'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->firstName(),
{elseif $key==='lastName'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->lastName(),
{elseif $key==='uuid'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->unique()->uuid(),
{elseif $key==='email'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->safeEmail(),
{elseif $field.ado->type=='enum'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->randomElement({$obj->upperCamel()}Type->getValues()),     // enum
{elseif $field.ado->type=='tinyint'}
            '{$field.ado->name}'{$field.ado->name|space_even} => (int) this->faker->boolean(),
{elseif $field.ado->type=='smallint' || $field.ado->type=='mediumint' || $field.ado->type=='int' || $field.ado->type=='bigint'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->randomDigitNotNull(),
{elseif $field.ado->type=='double'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->randomFloat($nbMaxDecimals = NULL, $min = 0, $max = NULL),
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->dateTime(),
{elseif $field.ado->type=='text' || $field.ado->type=='mediumtext' || $field.ado->type=='longtext'}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->lexify('?????? {$field.ado->name}') . ' ' . this->faker->emoji(),
{else}
            '{$field.ado->name}'{$field.ado->name|space_even} => this->faker->lexify('?????? {$field.ado->name}'),
{/if}
{/foreach}
        ];
        return [
            'name' => $this->faker->name,
            'email' => $this->faker->unique()->safeEmail,
            'email_verified_at' => now(),
            'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',  // password
            'remember_token' => Str::random(10),
        ];
    }
}








// laravel 7.x 以下
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
        '{$field.ado->name}'{$field.ado->name|space_even} => $faker->name(),    // $faker->word()
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
        'name'     => $faker->name(),
        'age'      => $faker->numberBetween(1, 120),
        'status'   => $faker->randomElement(['enabled', 'disabled']),
        'type'     => $faker->randomElement({$obj->upperCamel()}Type->getValues()),     // enum
        'type'     => Arr::random({$obj->upperCamel()}Type::cases()),                   // enum
        'timezone' => date_default_timezone_get(),
    ];
});

// 請查 https://github.com/fzaninotto/Faker
// 請查 https://www.cnblogs.com/love-snow/articles/7655450.html