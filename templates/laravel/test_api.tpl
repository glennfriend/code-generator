<?php
declare(strict_types=1);
{if $isModule}namespace Modules\{$obj->upperCamel()}\Tests\Entities;
{else        }namespace Tests\app\Entities;
{/if}

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$mod->upperCamel()};
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
{else}
use App\Entities\{$mod->upperCamel()};
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

        $this->url = '/api/{$obj->lower("-")}';

        /*
        $this->{$obj} = factory(Users::class)->create();
        $this->{$obj} = factory({$mod->upperCamel()}::class)->create([
            'user_id' => $this->user->id,
        ]);
        */
    }

   /**
     * @group only
     * @test
     */
    public function index_get()
    {
        factory({$obj->upperCamel()}::class)->create([
            'user_id'    => $this->user->id,
            'created_at' => '2019-01-31',
        ]);

        $this
            ->getAuthedRequest()
            ->json('GET', $this->url . '?' . http_build_query([
                'start_date' => '2000-01-01',
                'end_date'   => '2000-02-01',
            ]))
            ->assertStatus(200)
            ->assertJson([
                'data' => [
                    [
                        'date'  => '2019-01-31',
                        'count' => 2,
                    ],
                ],
            ]);

    }

    /**
     * @group only
     * @test
     */
    public function create_post()
    {
        $jsonFile = 'post-1.json';
        $this
            ->getAuthedRequest()
            ->json('POST', $this->url, $this->getTestJson($jsonFile))
            ->assertStatus(200)
            ->assertJson([
                'ok' => true,
            ]);

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
    protected function postHttp($jsonFile)
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

    protected function getAuthedRequest()
    {
        return $this
            ->withHeaders([
                'Authorization' => "Bearer {ldelim}$this->apiToken{rdelim}",
            ]);
    }

    /**
     * @param string $pathFile
     * @return mixed
     */
    protected function getTestJson($pathFile)
    {
        $jsonFile = base_path('app/Tests/Data/' . $pathFile);
        $text = file_get_contents($jsonFile);
        return json_decode($text, true);
    }

    protected function factory{$mod->upperCamel()}()
    {

    }
    
}

