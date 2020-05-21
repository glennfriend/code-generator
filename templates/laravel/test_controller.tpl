<?php
namespace Tests\app\Entities;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
{else}
use App\Entities\{$obj->upperCamel()};
{/if}

/**
 *
 */
final class {$obj->upperCamel()}ApiTest extends TestCase
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
     * @test
     */
    public function getAll_api_should_work()
    {
        factory({$obj->upperCamel()}::class, 3)->create([
{foreach $tab as $key => $field}
            '{$field.ado->name}'{$field.ado->name|space_even} => 'custom_to_cover_origin_data',
{/foreach}
        ]);

        $url = '/api/{$obj->lower("-")}';
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

