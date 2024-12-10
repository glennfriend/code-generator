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

        Role::create(['name' => 'system-admin']);
        $this->user = User::factory()->create();
        $this->user->assignRole('system-admin');
    }

    /**
     * @test
     */
    public function get_index_api_should_work()
    {
        factory({$obj->upperCamel()}::class, 3)->create([
{foreach $tab as $key => $field}
            '{$field.ado->name}'{$field.ado->name|space_even} => 'custom_to_cover_origin_data',
{/foreach}
        ]);

        $payload = [];
        $this->get______ServiceMock
            ->shouldReceive('perform')
            ->once()
            ->with($payload)
            ->andReturn(collect([]));


        $url = '/api/{$obj->lower("-")}/index';
        $response = $this->json('GET', $url, $payload);

        $response->assertStatus(200);
        $response->assertJsonCount(3, 'data');
        $response->assertJsonFragment([
            'data' => [
                ['name' => 'alice'],
                ['name' => 'bob'],
            ]
        ]);

    }

    /**
     * @test
     */
    public function create_should_success(): void
    {
        $url = "api/aaa-bbb";
        $response = $this
            ->actingAs($this->user)
            ->json('POST', $url, $this->expectedResponse);
        $response->assertStatus(ResponseAlias::HTTP_CREATED);
        $result = json_decode($response->getContent(), true);
        $this->assertEquals($this->expectedData['name'], $result['data']['name']);
        $this->assertEquals($this->account->id, $result['data']['accounts'][0]['id']);
    }

    /**
     * @test
     */
    public function create_should_failed(): void
    {
        $url = "api/aaa-bbb";
        $response = $this
            ->json('POST', $url, $this->expectedResponse);
        $response->assertStatus(ResponseAlias::HTTP_UNAUTHORIZED);
    }

    /**
     * @test
     */
    public function update_should_success(): void
    {
        $url = "api/aaa-bbb/{ldelim}$this->aaaBbb->id{rdelim}";
        $response = $this
            ->actingAs($this->user)
            ->json('PUT', $url, $this->expectedResponse);
        $response->assertStatus(ResponseAlias::HTTP_OK);
        $result = json_decode($response->getContent(), true);
        $this->assertEquals($this->expectedData['name'], $result['data']['name']);
    }

    /**
     * @test
     */
    public function update_should_failed(): void
    {
        $url = "api/aaa-bbb/{ldelim}$this->aaaBbb->id{rdelim}";
        $response = $this
            ->json('PUT', $url, $this->expectedResponse);
        $response->assertStatus(ResponseAlias::HTTP_UNAUTHORIZED);
    }

    /**
     * @test
     */
    public function destroy_should_success(): void
    {
        $url = "api/aaa-bbb/{ldelim}$this->aaaBbb->id{rdelim}";
        $response = $this
            ->actingAs($this->user)
            ->json('DELETE', $url);
        $response->assertStatus(ResponseAlias::HTTP_NO_CONTENT);
    }

    /**
     * @test
     */
    public function destroy_should_fail(): void
    {
        $url = "api/aaa-bbb/{ldelim}$this->aaaBbb->id{rdelim}";
        $response = $this
            ->json('DELETE', $url);
        $response->assertStatus(ResponseAlias::HTTP_UNAUTHORIZED);
    }

    // ------------------------------------------------------------
    //  private
    // ------------------------------------------------------------

    
}
