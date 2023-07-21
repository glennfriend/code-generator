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

    public function register()
    {
        /*
        if (! defined('{$obj->upper('_')}_PATH')) {
            define('{$obj->upper('_')}_PATH', dirname(__DIR__));
        }
        */

        $this->registerConfig();
        $this->registerCommands();
        $this->registerMiddlewares();
        $this->registerFactories();
        $this->registerScheduler();
        $this->singleton();
    }

    public function boot()
    {
        $this->registerMigrations();
        $this->registerSeeds();
        $this->registerResources();
        $this->offerPublishing();
        $this->registerRoutes();
        $this->registerContainer();
        $this->registerLogging();
    
    }

    // --------------------------------------------------------------------------------
    //  register
    // --------------------------------------------------------------------------------

    /**
     * Setup the configuration
     * NOTE: file name 與 key 請設定成同名
     *
     * @return void
     */
    protected function registerConfig()
    {
        // 舊的
        // $this->mergeConfigFrom(dirname(__DIR__) . '/config/{$obj->lower('_')}.php',      '{$obj->lower('_')}');
        // $this->mergeConfigFrom(dirname(__DIR__) . '/config/{$obj->lower('_')}_menu.php', '{$obj->lower('_')}_menu');

        // 請改成用 - 符號連接
        $this->mergeConfigFrom(dirname(__DIR__) . '/config/{$obj->lower('-')}.php',      '{$obj->lower('-')}');
        $this->mergeConfigFrom(dirname(__DIR__) . '/config/{$obj->lower('-')}-menu.php', '{$obj->lower('-')}-menu');
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
     * @see app/Http/Kernel.php
     */
    protected function registerMiddlewares()
    {
        /**
         * @var Router $router
         */
        // $router = $this->app['router'];
        // $router->pushMiddlewareToGroup('auth:jwtOrAccountApiKey', \Modules\Auth\Http\Middleware\AuthByJwtOrAccountApiKey::class);
        // $router->pushMiddlewareToGroup('auth.token',              \Modules\Auth\Http\Middleware\TokenAuthorization::class);
        // $router->pushMiddlewareToGroup('xxxxx.auth',              UserLoginAuth::class);

        // how to use
        /*
        Route::middleware('auth:jwtOrAccountApiKey')->group(function() {
            Route::get('agents', 'AgentController@index');
        })
        */
    }

    protected function registerFactories()
    {
        $this->app
            ->make('Illuminate\Database\Eloquent\Factory')
            ->load(__DIR__ . '/../database/factories');
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

        $this->app->booted(function () {
            $schedule = $this->app->make(Schedule::class);
            $schedule
                ->command(ExecuteMyPlanJobsCommand::class, ['--account_id=100'])
                ->dailyAt('00:00');
        });

        */
    }

    /**
     * objects init
     */
    public function singleton()
    {
        /*
        app()->singleton(GoogleAdsClient::class, function () {
            $config = base_path('google_ads_php.ini');
            return (new GoogleAdsClientBuilder())->fromFile($config)
                ->options([])
                ->build();
        });

        app()->singleton(GoogleAdsClient::class, function () {
            return new HelloFactory(
                app()->make(Happy::class), 
                new AdWordsServices()
            );
        });
        */
    }

    // --------------------------------------------------------------------------------
    //  boot
    // --------------------------------------------------------------------------------

    /**
     * Register the migrations
     *
     * @return void
     */
    protected function registerMigrations()
    {
        $this->loadMigrationsFrom(dirname(__DIR__) . '/database/migrations');
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
        $this->loadViewsFrom(dirname(__DIR__) . '/resources/views', '{$obj->lower('_')}');
    }

    /**
     * 發佈資源檔
     *      如果要覆蓋, 後面要加上 --force
     * 
     * php artisan vendor:publish  --tag=my-publish-name
     *      - config/
     *      - public/vendor/[package-name]/
     */
    protected function offerPublishing()
    {
        if (! $this->app->runningInConsole()) {
            return;
        }

        $myPublishName = '{$obj->lower('-')}';

        //
        $this->publishes([
            dirname(__DIR__) . '/config/' . '{$obj->lower('-')}.php' => config_path('{$obj->lower('-')}.php'),
        ], $myPublishName);
        // or -> your-package-name-config

        $this->publishes([
            dirname(__DIR__) . '/resources/js' => public_path('vendor/{$obj->lower('-')}/js'),
        ], $myPublishName);
        // or -> your-package-name-resource

        // $this->publishes([
        //     dirname(__DIR__) . '/database/migrations/' => database_path('migrations'),
        // ], 'your-package-name-migration');
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
            $this->loadRoutesFrom(dirname(__DIR__) . '/routes/web.php');
        });

        Route::group([
            'prefix'    => '/api/{$obj->lower('-')}',
            'namespace' => '{$obj->upperCamel()}\Http\Controllers',
        ], function () {
            $this->loadRoutesFrom(dirname(__DIR__) . '/routes/api.php');
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
     * $message = '';
     * $option = [];
     * Log::channel('{$obj->lower('_')}')->debug($message, $option);
     */
    protected function registerLogging()
    {
        $this->app->make('config')->set('logging.channels.{$obj->lower('_')}', [
            'driver' => 'single',
            'path'   => storage_path('logs/{$obj->lower('_')}.log'),
            'level'  => 'debug',
            'days'   => 90,
        ]);
    }



}
