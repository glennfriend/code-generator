<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Tests\Entities;
{else        }namespace Tests\app\Entities;
{/if}

use Tests\TestCase;
use GuzzleHttp;
use Mockery;
use Illuminate\Foundation\Testing\RefreshDatabase;
{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$mod->upperCamel()};
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Services\{$obj->upperCamel()}Service;
{else}
use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};
use App\Services\{$obj->upperCamel()}Service;
{/if}

/**
 *
 */
final class {$obj->upperCamel()}ControllerTest extends TestCase
{
    use RefreshDatabase;

    /**
     *
     */
    public function setUp(): void
    {
        parent::setUp();

        /*
        $this->user = factory(User::class)->create();
        $this->{$obj} = factory({$obj->upperCamel()}::class)->create([
            'user_id' => $this->user->id,
        ]);
        */

        /*
        $this->account = factory(Account::class)->create();
        $this->{$obj} = factory({$obj->upperCamel()}::class)->create([
            'account_id' => $this->account->id,
        ]);
        */
    }

   /**
     * @group only
     * @test
     */
    public function index_should_work()
    {
        factory({$obj->upperCamel()}::class)->create([
            'account_id' => $this->account->id,
            'created_at' => '2019-01-31',
        ]);

        $accountId = $this->account->id;
        $payload = [
            'start_date' => '2000-01-01',
            'end_date'   => '2000-02-01',
        ];
        $url = "/api/accounts/{ldelim}$accountId{rdelim}/{$mod->lower('-')}";
        $url .= '?' . http_build_query($payload);

        $response = $this->getAuthedRequest()->json('GET', $url);

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => [
                    'id',
                    'account_id',
                    'config',
                ]
            ]
        ]);
        $response->assertJsonFragment([
            'data' => [
                [
                    'id'    => 1,
                    'date'  => '2019-01-31',
                    'count' => 2,
                ],
            ],
        ]);
        $response->assertJson([
            'data' => [
                [
                    'date'  => '2019-01-31',
                    'count' => 2,
                ],
            ],
        ]);

        //
        $json = json_decode($response->getContent(), true);
        $this->assertEquals('2', $json['data'][0]['count']);

    }

    /**
     * @group only
     * @test
     */
    public function store_should_work()
    {
        // $this->mockService();

        $accountId = $this->account->id;
        $url = "/api/accounts/{ldelim}$accountId{rdelim}/{$mod->lower('-')}";

        $payload = $this->getTestJson('{$obj->lower('_')}_store.json');
        $response = $this->getAuthedRequest()->json('POST', $url, $payload);

        //
        // dump(json_decode($response->getContent(), true));
        $response->assertStatus(201);
        $response->assertJsonStructure([
            'data' => [
                'id',
                'account_id',
                'config',
            ]
        ]);
        $response->assertJsonFragment([
            'name' => '{$obj} store',
        ]);

        /*
            // 可以嘗試看看這個方法
            $this->assertDatabaseHas('{$obj->lower('_')}', [
                'title' => 'Skyfall',
                'release_date' => '2012-10-27'
            ]);
        */
    }

    /**
     * @group only
     * @test
     */
    public function update_should_work()
    {
        $accountId = $this->account->id;
        ${$obj}Id = $this->{$obj}->id;
        $url = "/api/accounts/{ldelim}$accountId{rdelim}/{$mod->lower("-")}/{ldelim}${$obj}Id{rdelim}";

        $payload = $this->getTestJson('{$obj->lower('_')}_update.json');
        $response = $this->getAuthedRequest()->json('PATCH', $url, $payload);

        //
        // dump(json_decode($response->getContent(), true));
        $response->assertStatus(201);
        $response->assertJsonStructure([
            'data' => [
                'id',
                'account_id',
                'config',
            ]
        ]);
        $response->assertJsonFragment([
            'name' => '{$obj} update',
        ]);
    }

    /**
     * @group only
     * @test
     */
    public function delete_should_work()
    {
        $accountId = $this->account->id;
        ${$obj}Id = $this->{$obj}->id;
        $url = "/api/accounts/{ldelim}$accountId{rdelim}/{$mod->lower("-")}/{ldelim}${$obj}Id{rdelim}";
        $response = $this->getAuthedRequest()->json('DELETE', $url);

        $response->assertStatus(204);
    }


    /**
     * @group only
     * @test
     */
    public function create_post()
    {
        $response = [];

        //
        ${$mod} = app({$mod->upperCamel()}::class);
        ${$obj} = ${$mod}->get(1);
        $email = ${$obj}->getEmail();

        //
        $this->assertEquals('alice@mail.com', $email);
    }

    // ------------------------------------------------------------
    //  private
    // ------------------------------------------------------------

    /*
    private function postHttp($jsonFile)
    {
        $url = '/api/{$obj->lower("-")}';
        $this
            ->getAuthedRequest()
            ->json('POST', $url, $this->getTestJson($jsonFile))
            ->assertStatus(200)
            ->assertJson([
                'ok' => true,
            ]);
    }
    */

    private function getAuthedRequest()
    {
        Event::fake();
        $user = factory(User::class)->create();
        $apiToken = auth('api')->login($user);
        return $this
            ->withHeaders([
                'Authorization' => "Bearer {ldelim}$apiToken{rdelim}",
            ]);
    }

    /**
     * @param string $pathFile
     * @return array
     */
    private function getTestJson(string $pathFile): array
    {
        $json = <<<EOD
{
    "customerId": "111-222-3333",
    "language": "US",
    "type": "geo",
    "campaignIds": [
        "11111"
    ]
}
EOD;
        return json_decode($json, true);

{if $isModule}
        $basePath = base_path('Modules/{$obj->upperCamel()}/Tests/Data/Controllers');
{else}
        $basePath = base_path('app/Tests/Data');
{/if}
        $text = file_get_contents($basePath . '/' . $pathFile);
        return json_decode($text, true);
    }

    /**
     *
     */
    private function mockService()
    {
        $class = {$obj->upperCamel()}Service::class;
        $this->instance($class, Mockery::mock($class, function ($mock) {
            // $mock->shouldAllowMockingProtectedMethods()->makePartial();      <<---- 不應該有這個情況

            $psrResponse = new GuzzleHttp\Psr7\Response('200', [], '{ldelim}id: 123{rdelim}');
            $mock
                ->shouldReceive('callThirdPartyApi')
                ->andReturn($psrResponse);

            $mock
                ->shouldReceive('updateSomething');

        }));

        $class = {$obj->upperCamel()}TemplateService::class;
        $this->instance($class, Mockery::mock($class, function ($mock) {
            $mock
                ->shouldReceive('renderTemplate')
                ->andReturn('');
        }));

    }

}

