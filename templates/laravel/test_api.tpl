<?php
namespace Tests\app\Entities;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};

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
     * @group only
     */
    public function test_post()
    {
        $json = 'post-1.json';
        $this->postHttp($json);

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

    protected function postHttp($jsonFile)
    {
        $api = '/api/{$obj->lower("_")}';
        $this
            ->getThis()
            ->json('POST', $api, $this->getTestJson($jsonFile))
            ->assertStatus(200)
            ->assertJson([
                'ok' => true,
            ]);
    }

    protected function getThis()
    {
        return $this
            ->withHeaders([
                'Authorization' => "Bearer $this->apiToken",
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

