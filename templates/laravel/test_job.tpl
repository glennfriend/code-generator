<?php
namespace Modules\{$obj->upperCamel()}\Tests\Jobs;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Support\Facades\Event;

/**
 * 
 */
final class {$obj->upperCamel()}Job extends TestCase
{
    // use RefreshDatabase;

    /**
     *
     */
    public function setUp(): void
    {
        parent::setUp();
        Bus::fake();    // Job dispatch() 會進到 construct, 但是不會呼叫 handle
        Event::fake();
    }

    /**
     * @test
     */
    public function event_trigger()
    {
        $this->account = factory(Account::class)->create();
        $this->blog = factory(Blog::class)->create([
            'account_id' => $this->account->id,
        ]);

        Event::fakeFor(function () {
            $attributes = [
                "email" => "test1@example.com",
            ];

            $job = new {$obj->upperCamel()}($attributes);
            $job->handle(...$this->getHandleInject());

            Event::assertDispatched({$obj->upperCamel()}CreatingEvent::class, 1);
            Event::assertDispatched({$obj->upperCamel()}CreatedEvent::class, 1);
            Event::assertDispatched({$obj->upperCamel()}CreateFilEvent::class, 1);
            Event::assertNotDispatched({$obj->upperCamel()}CreateFailedEvent::class);
        });
    }

    /**
     * @test
     */
    public function handle_should_create_success()
    {
        $this->account = factory(Account::class)->create();
        $attributes = [
            "account_id" => 1,
            "email"      => "test1@example.com",
        ];
        $job = new {$obj->upperCamel()}Job($attributes);
        $job->handle(...$this->getHandleInject());

        // to validate
        ${$obj}Repository = app({$obj->upperCamel()}Repository::class);
        ${$obj} = ${$obj}Repository->find(1);
        $this->assertEquals(${$obj}->email, $attributes['email']);
    }

    // ------------------------------------------------------------
    //  private
    // ------------------------------------------------------------

    private function getHandleInject(): array
    {
        return [
            app({$obj->upperCamel()}Service::class),
            app({$obj->upperCamel()}Repository::class),
        ];
    }
    
}

/*
controller example
使用 "DispatchesJobs" 的問題在於 dispatch() 名稱如果在 Job 裡面使用會有名稱衝突
所以可能要想個辦法讓兩邊的寫法一致?

    $job = {$obj->upperCamel()}Job::dispatch($input)->onQueue('high');

or

    class {$obj->upperCamel()}Controller
    {
        use DispatchesJobs;

        public function createJob()
        {
            $job = (new {$obj->upperCamel()}Job($params))->onQueue('high');

            // 取得進到 queue 裡面的 job id (task id)
            $jobId = $this->dispatch($job);

            print_r($job);
            print_r($jobId);
        }
    }

*/