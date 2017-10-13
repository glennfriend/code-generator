<?php

/**
 *
 */
class {$obj->upperCamel()}Test extends PHPUnit_Framework_TestCase
{
    /**
     *
     */
    public function setUp()
    {
        // include library
        // reset env
        // reset variables
    }

    /**
     * test value object basic get/set
     */
    public function testDbobjectBasicAccess()
    {
        //
        $obj = new {$obj->upperCamel()}();
{foreach $tab as $key => $field}
{if $key === 'id'}
        $obj->setId                  ('123'                  );
{else}
        $obj->{$field.name->set()}{$key|space_even}('{$field.ado->type}' {$field.ado->type|space_even});
{/if}
{/foreach}

        //
        $this->assertEquals(
            '123',
            $obj->getId(),
            '${$obj}->getId() 取得的資料型態不正確, 應該要自動轉換為 int 型態'
        );

        //
        $obj->setFirstName('aa');
        $obj->setLastName('bb');
        $this->assertEquals(
            'aa bb',
            $obj->getFullName(),
            '${$obj}->getFullName() 取得的值有問題'
        );

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

