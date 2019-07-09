<?php
namespace Tests\app\Entities;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};

/**
 *
 */
class {$obj->upperCamel()}Test extends TestCase
{
    /**
     *
     */
    public function setUp(): void
    {
        parent::setUp();
        $this->{$mod->lowerCamel()} = $this->app->make({$mod->upperCamel()}::class);
     // $this->{$mod} = app({$mod->upperCamel()}::class);

        // dependency injection
        // include library
        // reset env
        // reset variables
    }

    /**
     * @testdox {$obj->upperCamel()} value object basic get/set
     */
    public function test_create{$obj->upperCamel()}()
    {
        $object = $this->factory{$obj->upperCamel()}();
        ${$obj} = $this->{$mod}->add($object);

        //
        $this->assertEquals(
            '123',
            ${$obj}->getId(),
            '${$obj}->getId() 取得的資料型態不正確, 應該要自動轉換為 int 型態'
        );

        //
        ${$obj}->setFirstName('aa');
        ${$obj}->setLastName('bb');
        $this->assertEquals(
            'aa bb',
            ${$obj}->getFullName(),
            '${$obj}->getFullName() 取得的值有問題'
        );

    }

    // ------------------------------------------------------------
    //  private
    // ------------------------------------------------------------

    protected function factory{$obj->upperCamel()}()
    {
        ${$obj} = ${$mod}->vo();

{foreach $tab as $key => $field}
{if $key==='id'}
{elseif $key==='attribs'}
     // ${$obj}->setAttrib              ('key', 'value');
{elseif $key==='createdAt'}
     // ${$obj}->setCreatedAt           (time());
{elseif $key==='updatedAt'}
        ${$obj}->setUpdatedAt           (time());
{elseif $field.ado->type=='tinyint' || $field.ado->type=='smallint' || $field.ado->type=='mediumint' || $field.ado->type=='int'}
        ${$obj}->{$field.name->set()}{$key|space_even}(0);
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
        ${$obj}->{$field.name->set()}{$key|space_even}('2000-01-01');
{else}
        ${$obj}->{$field.name->set()}{$key|space_even}('{$field.ado->type}');
{/if}
{/foreach}
        // $obj->setName(data_get($data, 'my.name'));

        return ${$obj};
    }

    protected function getData()
    {
        $data = [
{foreach from=$tab key=key item=field}
            '{$field.ado->name}'{$key|space_even} => '',
{/foreach}
        ];
    }

}


// Check 1 === 1 is true
$this->assertTrue(1 === 1);

// Check 1 === 2 is false
$this->assertFalse(1 === 2);

// Check 'Hello' equals 'Hello'
$this->assertEquals('Hello', 'Hello');

// Check array has key 'language'
$this->assertArrayHasKey('language', ['language' => 'php', 'size' => '1024']);

// Check array contains value 'php'
$this->assertContains('php', ['php', 'ruby', 'c++', 'JavaScript']);

