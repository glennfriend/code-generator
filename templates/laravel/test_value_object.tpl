<?php
namespace Tests\app\Entities;

use Tests\TestCase;
use Illuminate\Foundation\Testing\{ldelim}RefreshDatabase, DatabaseTransactions{rdelim};
use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};
use App\Entities\Eloquent\{$obj->upperCamel()}Eloquent;
// use Modules\______\Entities\{$mod->upperCamel()};
// use Modules\______\Entities\{$obj->upperCamel()};
// use Modules\______\Entities\Eloquent\{$obj->upperCamel()}Eloquent;

/**
 *
 */
final class {$obj->upperCamel()}Test extends TestCase
{
    use DatabaseTransactions;

    /**
     *
     */
    public function setUp(): void
    {
        parent::setUp();

        $this->initBuild();
        // dependency injection
        // include library
        // reset env
        // reset variables
    }

    /**
     * @testdox {$obj->upperCamel()} value object basic get/set
     */
    final public function test_create_{$obj->lowerCamel()}()
    {
        ${$obj} = $this->{$mod}->get(1);
     // ${$obj} = $this->{$mod}->get($this->{$obj}Eloquent_1->id);


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

    protected function initBuild()
    {
        $this->{$obj}Eloquent_1 = factory({$obj->upperCamel()}Eloquent::class)->create();

        //
        $this->{$mod->lowerCamel()} = $this->app->make({$mod->upperCamel()}::class);
     // $this->{$mod} = app({$mod->upperCamel()}::class);
        ${$obj} = $this->{$mod}->vo();
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
        $this->{$mod}->add(${$obj});
    }

    /*
    protected function getData()
    {
        $data = [
{foreach from=$tab key=key item=field}
            '{$field.ado->name}'{$field.ado->name|space_even} => '',
{/foreach}
        ];
    }
    */

    /*
    protected function createElquentData()
    {
        // $faker = \Faker\Factory::create();

        // ->make()     不會進到 database
        // ->create()   建立到 database
        $contact = factory({$obj->upperCamel()}::class)->create([
{foreach from=$tab key=key item=field}
            '{$field.ado->name}'{$field.ado->name|space_even} => '',
{/foreach}
        ]);
    }
    */

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

