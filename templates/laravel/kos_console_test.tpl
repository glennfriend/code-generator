<?php

declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Tests\Console;
{else        }namespace Tests\app\Console;
{/if}

use Tests\TestCase;
use Mockery;
{if $isModule}
{else}
{/if}

/**
 *
 */
final class {$obj->upperCamel()}ConsoleTest extends TestCase
{
    public function setUp(): void
    {
        parent::setUp();

        $this->accountIds = [1, 2, 3];
    }


   /**
     * @test
     */
    public function handle_should_work(): void
    {
        $this
            ->artisan('{$obj->lower('_')}:hello-world', [
                'type' => $type,
                'key' => $key,
                'name' => $name,
                '--required' => true,
                '--account-ids' => implode(',', $this->accountIds),
            ])
            ->assertExitCode(0);
    }

}

