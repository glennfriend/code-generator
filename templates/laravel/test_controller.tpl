<?php
namespace Tests\app\Entities;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

/**
 *
 */
class {$obj->upperCamel()}ApiTest extends TestCase
{
    // use RefreshDatabase;

    /**
     *
     */
    public function setUp(): void
    {
        parent::setUp();
    }

    /**
     *
     */
    public function getAll_api_test()
    {
        factory({$mod->upperCamel()}::class, 3)->create(
{foreach $tab as $key => $field}
            '{$field.ado->name}'{$field.ado->name|space_even} => 'custom_to_cover_origin_data',
{/foreach}
        );

        $url = '/api/{$mod->lowerCamel("_")}';
        $response = $this->json('GET', $url);

        $response->assertStatus(200);
        $response->assertJsonCount(3, 'data');
        $response->assertJsonFragment([
            'data' => [
                ['name' => 'alice'],
                ['name' => 'bob'],
            ]
        ]);

    }

    // ------------------------------------------------------------
    //  private
    // ------------------------------------------------------------

    
}

