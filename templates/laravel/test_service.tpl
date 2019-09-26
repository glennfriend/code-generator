<?php
namespace Tests\app\Services;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Mockery;
use GuzzleHttp\Psr7;
use Modules\______\Services\{$obj->UpperCamel()}Service;

/**
 *
 */
class {$obj->upperCamel()}ServiceTest extends TestCase
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
    }

    /**
     * @group only
     */
    public function getEmailTemplate_should_work_test()
    {
        // the service used injection object
        $this->service->templateVariableService = $this->app->make(TemplateVariableService::class);
        // the service method used object
        /*
        $this->user = factory(User::class)->create();
        $this->blog = factory(Action::class)->create([
            'user_id' => $this->user->id,
        ]);
        */


        //
        $row = file_get_contents(__DIR__ . '/../../data/xxxxxxxx.json');
        $this->service->shouldReceive('getUser')->andReturn($row);

        //
        $result = $this->service->getEmailTemplate();
        
        $this->assertEquals(123, data_get('data.user.id', $result));
        $this->assertJsonCount(3, data_get('data', $result));
        $this->assertNotRegExp(
            '/{ldelim}{ldelim}/',
            data_get('data.template.body', $result),
            'have not redner variable in template'
        );
    }

    /**
     * @group only
     */
    public function getApi_should_work_test()
    {
        $row = file_get_contents(__DIR__ . '/../../data/xxxxxxxx.json');
        $psrResponse = new Psr7\Response('200', [], $row);
        $this->service->shouldReceive('getPsrResponse')->andReturn($psrResponse);

        //
        $result = $this->service->getRemoteData();
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    
}

