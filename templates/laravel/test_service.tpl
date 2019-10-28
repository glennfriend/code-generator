<?php
namespace Tests\app\Services;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Mockery;
use GuzzleHttp;
use Modules\______\Services\{$obj->UpperCamel()}Service;
use Modules\______\Repositories\{$obj->UpperCamel()}Repository;

/**
 *
 */
final class {$obj->upperCamel()}ServiceTest extends TestCase
{
    // use RefreshDatabase;

    /**
     *
     */
    public function setUp(): void
    {
        parent::setUp();

        $this->service = Mockery::mock({$obj->upperCamel()}Service::class)
            ->shouldAllowMockingProtectedMethods()
            ->makePartial();

        // the service used injection class
        $this->service->{$obj}Repository        = $this->app->make({$obj->UpperCamel()}Repository::class);
        $this->service->apiService              = $this->app->make(ApiService::class);
        $this->service->otherService            = $this->app->make(OtherService::class);
    }

    /**
     * @group only
     * @test
     */
    public function getEmailTemplate_should_work()
    {
        // the service method used object
        /*
        $this->user = factory(User::class)->create();
        $this->blog = factory(Blog::class)->create([
            'user_id' => $this->user->id,
        ]);
        */


        //
        $json = file_get_contents(__DIR__ . '/data/xxxxxxxx.json');
        $this->service->shouldReceive('getUser')->andReturn($json);

        //
        $result = $this->service->getEmailTemplate();
        
        $this->assertEquals(123, data_get('data.user.id', $result));
        $this->assertJsonCount(3, data_get('data', $result));
        $this->assertNotRegExp(
            '/{ldelim}name{rdelim}/',
            data_get('data.template.body', $result),
            'have not redner variable in template'
        );
    }

    /**
     * @group only
     * @test
     */
    public function fetchRemoteData_should_work()
    {
        $json = file_get_contents(__DIR__ . '/../../data/xxxxxxxx.json');
        $psrResponse = new GuzzleHttp\Psr7\Response('200', [], $json);
        $this->service->shouldReceive('getPsrResponse')->andReturn($psrResponse);

        //
        $result = $this->service->fetchRemoteData();
    }

    /**
     * @group only
     * @test
     */
    public function todo_should_work()
    {
        $object = new class {
            public function body() {
                $json = '
{
    "versions": [
        {
            "id": 123,
            "subject": "my subject"
        }
    ]
}
';
                return $json;
            }
        };
        $this->service->shouldReceive('getObject')->andReturn($object);

        //
        $result = $this->service->todo();
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    
}

