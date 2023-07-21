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
// ______UseCase
final class Get{$obj->upperCamel()}ServiceTest extends TestCase
{
    // use RefreshDatabase;

    /**
     *
     */
    public function setUp(): void
    {
        parent::setUp();

        $this->service = $this->app->make(Get{$obj->upperCamel()}Service);
    }

    /**
     * @group only
     * @test
     */
    public function perform_should_work()
    {
        $this->assertEquals(1, 2);
    }
}
