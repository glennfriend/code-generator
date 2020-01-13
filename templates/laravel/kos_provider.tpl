<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Providers;
{else        }namespace App\Providers\{$obj->upperCamel()};
{/if}

use Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Illuminate\Contracts\Events\Dispatcher;
use Illuminate\Console\Scheduling\Schedule;

{if $isModule}
use Modules\{$obj->upperCamel()}\Console;
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Repositories\{$obj->upperCamel()}Repository;
{else}
use App\Console\{$obj->upperCamel()};
use App\Entities\{$obj->upperCamel()};
use App\Repositories\{$obj->upperCamel()}Repository;
{/if}

/**
 * {$obj->upperCamel()} Provider
 */
class {$obj->upperCamel()}Provider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerMigrations();
        $this->registerSeeds();
        $this->registerResources();
        $this->registerRoutes();
        $this->registerContainer();

        // append middleware
        // $router = $this->app['router'];
        // $router->pushMiddlewareToGroup('xxxxxx.auth',  UserLoginAuth::class);
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        if (! defined('{$obj->upper('_')}_PATH')) {
            define('{$obj->upper('_')}_PATH', dirname(__DIR__));
        }

        $this->configure();
        $this->offerPublishing();
        $this->registerCommands();
        $this->registerScheduler();
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------


    /**
     * Register the migrations
     *
     * @return void
     */
    protected function registerMigrations()
    {
        $this->loadMigrationsFrom({$obj->upper('_')}_PATH . '/database/migrations');
    }

    /**
     * 目前使用的 laravel 5.8 沒有提供 seed for packages
     * 請撰寫 console command 的方式來執行 seeds
     */
    protected function registerSeeds()
    {
    }

    /**
     * Register the resources
     *
     * @return void
     */
    protected function registerResources()
    {
        $this->loadViewsFrom({$obj->upper('_')}_PATH . '/resources/views', '{$obj->lower('_')}');
    }

    /**
     * Register the routes
     *
     * @return void
     */
    protected function registerRoutes()
    {
        Route::group([
            //'prefix'     => config('{$obj->lower('_')}.uri', '{$obj->lower('_')}'),
            'namespace'    => '{$obj->upperCamel()}\Http\Controllers',
            //'middleware' => '{$obj->lower('_')}.auth',
        ], function () {
            $this->loadRoutesFrom({$obj->upper('_')}_PATH . '/routes/web.php');
        });
    }
    
    protected function registerContainer()
    {
        /*
        $this->app->singleton(Aws::class, function ($app) {
            $aws = new Aws();
            $profile = env('AWS_PROFILE');
            $ownerId = env('AWS_OWNER_ID');

            $aws->setOwnerId($ownerId);
            $aws->setProfile($profile);
            return $aws;
        });
        */
    }

    /**
     * Setup the configuration
     *
     * @return void
     */
    protected function configure()
    {
        $this->mergeConfigFrom({$obj->upper('_')}_PATH . '/config/{$obj->lower('_')}.php',      '{$obj->lower('_')}');
        $this->mergeConfigFrom({$obj->upper('_')}_PATH . '/config/{$obj->lower('_')}_menu.php', '{$obj->lower('_')}_menu');
    }

    /**
     * 發佈資源檔
     *      - config/
     *
     * @return void
     */
    protected function offerPublishing()
    {
        if ($this->app->runningInConsole()) {
            $this->publishes([
                {$obj->upper('_')}_PATH . '/config/{$obj->lower('_')}.php' => config_path('{$obj->lower('_')}.php'),
            ], '{$obj->lower('_')}-config');
        }
    }

    /**
     * Register the Artisan commands.
     *
     * @return void
     */
    protected function registerCommands()
    {
        if (! $this->app->runningInConsole()) {
            return;
        }

        $this->commands([
            Console\UserCreate::class,
            Console\BlogCreate::class,
            Console\Seed::class,
            Console\TestCommands\TestOnly::class,
            Console\TestCommands\TestJob::class,
            Console\TestApiCommands\TestGoogleSheet::class,
            Console\OneTimeCommands\DataMigration_2000_01_01::class,
        ]);
    }

    /**
     * crontab example
     *      => crontab -e
     *      => * * * * * cd /your-project && /home/ubuntu/.phpbrew/php/php-7.4.0/bin/php artisan schedule:run >> /dev/null 2>&1
     */
    public function registerScheduler()
    {
        /*
        $this->app->booted(function () {
            $arguments = [
                'arg-1',
                'arg-2',
                'arg-3',
            ];

            $this->app->make(Schedule::class)
                ->command(CreateReportCache::class, $arguments)
                ->everyMinute()    // 每分鐘執行一次
                ->environments(['local'])
            ;
        });
        
        $this->app->booted(function () {
            $schedule = $this->app->make(Schedule::class);
            $schedule
                ->job(new AddBlogToAllUsersJob())
                ->dailyAt('01:00')  // 每天零辰 01:00 執行一次
                ->environments(['staging', 'production'])
            ;
        });

        $this->app->booted(function () {
            $schedule = $this->app->make(Schedule::class);
            $schedule
                ->command(CreateReportCache::class, [])
                ->everyThirtyMinutes()
                ->withoutOverlapping(60)
                ->runInBackground()
            ;
        });
        */
    }

}
