<?php

{if $isModule}namespace Modules\{$obj->upperCamel()}\Tests\Http\Requests;
{else        }namespace Tests\app\Http\Requests;
{/if}

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Validator;
use Modules\{$obj->upperCamel()}\Http\Requests\{$obj->upperCamel()}Request;
use Tests\TestCase;

class {$obj->upperCamel()}RequestTest extends TestCase
{
    public function setUp(): void
    {
        parent::setUp();
        $this->request = new {$obj->upperCamel()}();
    }

    /**
     * @test
     */
    public function rules_should_work()
    {
        $validator = Validator::make([
            "email"        => "test@example.com",
            "phone_number" => "+11234567890",
        ], $this->request->rules());

        $this->assertEmpty($validator->errors()->keys());
    }

    /**
     * @test
     */
    public function invalid_phone_number_format_should_fail()
    {
        $validator = Validator::make([
            "phone_number" => "1234",
        ], $this->request->rules());

        $messages = $validator->errors()->messages();
        $this->assertTrue("The phone number must comply with E.164" === $messages['phone_number'][0]);
    }
}