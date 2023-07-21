<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Rules;
{else        }namespace App\Rules;
{/if}

use Illuminate\Contracts\Validation\Rule;

/**
 * @see https://en.wikipedia.org/wiki/E.164
 */
class E164PhoneNumber implements Rule
{
    /**
     * @param string $attribute
     * @param mixed $value
     */
    public function passes($attribute, $value): bool
    {
        $pattern = '/^\+[1-9]\d{ldelim}1,14{rdelim}$/';
        if (!preg_match($pattern, $value)) {
            return false;
        }

        return true;
    }

    public function message(): string
    {
        return 'The :attribute must comply with E.164';
    }
}