<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Jobs;
{else        }namespace App\Jobs;
{/if}

use Exception;
use Illuminate\Support\Facades\Log;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;

/*
{if $isModule}
use Modules\{$obj->upperCamel()}\Entities\{$mod->upperCamel()};
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
use Modules\{$obj->upperCamel()}\Http\Resources\{$obj->upperCamel()}Resource;
{else}
use App\Entities\{$mod->upperCamel()};
use App\Entities\{$obj->upperCamel()};
use App\Services\{$obj->upperCamel()}\{$obj->upperCamel()}Service;
use App\Http\Resources\{$obj->upperCamel()}Resource;
{/if}
*/

/**
 * 幂等性: 該 job 是否可以重覆執行, 並且有相同的結果: yes/no
 */
class {$obj->upperCamel()}Job implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable;

    /**
     * @var int 
     */
    public $tries = 1;

    /**
     * @var array
     */
    protected $attributes;

    /**
     *
     */
    public function __construct(array $attributes)
    {
        /**
         * @var string $queue, queue level see "config/horizon.php"
         */
        $this->queue = 'default';
        $this->attributes = $attributes;

        $this->dispatchBeforeValidate();
    }

    /**
     *
     */
    public function handle(
        {$obj->upperCamel()}Service ${$obj}Service,
        {$obj->upperCamel()}Repository ${$obj}Repository
    )
    {
        ini_set('memory_limit', '512M');

        //
        $accountId = $this->attributes['account_id'];
        $email     = data_get($this->attributes, 'email');
        $this->{$obj}Service    = ${$obj}Service;
        $this->{$obj}Repository = ${$obj}Repository;


        $this->log('info', "job start by {ldelim}$accountId{rdelim}", [
            'account_id' => $accountId,
            'email'      => $email,
        ]);
        $this->perform($this->attributes);
        $this->log('info', "job end");
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     * @throws Exception
     */
    protected function perform(array $input)
    {
        $accountId = $input['account_id'];

        try {

            // TODO: something

        } catch (Exception $exception) {
            $params = [
                'account_id' => $accountId,
                'error'      => $exception->getMessage(),
            ];
            $this->log('error','Exception', $params);
            throw $exception;
        } finally {
            if (isset($exception)) {
                //
            }
            else {
                //
            }
        }
    }

    /**
     * 這裡是對 未進入到 job 之前的檢查
     * 所以這裡沒辦法直接使用 DI
     * 
     * check list
     *      - 檢查 job 必須要的參數是否存在
     *      - job 如果要的資料沒有先輸入, 之後再抓會有錯誤的可能, 可以考慮 query 出來先檢查
     */
    protected function dispatchBeforeValidate()
    {
        if (! isset($this->attributes['account_id'])) {
            throw new Exception("error");
        }

        // $account = app(Account::class);
    }

    protected function dispatch_example()
    {
        /*
        $attributes = [
            'account_id' => '',
        ];

        try {
            // $queueName = 'default'; // see "config/horizon.php"
            // \App\Jobs\YourJob::dispatch($attributes)->onQueue($queueName);

            \App\Jobs\YourJob::dispatch($attributes);
            $request->session()->flash('success-message', 'Task was queue');
        } catch (Exception $exception) {
            $error = $exception->getMessage();
            Log::error($error, $attributes);
            $request->session()->flash('error-message', $error);
            // throw $exception;
        }
        */
    }

    /**
     * @param string $type
     * @param string $message
     * @param array $option
     */
    protected function log(string $type, string $message, array $option=[])
    {
        if ($this->job) {
            // test mode can't get $this->job
            $option['job_id'] = $this->job->getJobId();
        }

        $name = __CLASS__;
        if ($pos = strrpos($name, '\\')) {
            $name = substr($name, $pos + 1);
        }
        
        $message = "[{ldelim}$name{rdelim}] {ldelim}$message{rdelim}";
        Log::$type($message, $option);

        // setting "config/logging.php"
        // Log::channel('your_channel')->$type($message, $option);
    }

}
