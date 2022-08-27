<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Jobs;
{else        }namespace App\Jobs;
{/if}

use Exception;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Log;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

{if $isModule}
use Modules\{$obj->upperCamel()}\DataTransferObjects\{$obj->upperCamel()}Params;
use Modules\{$obj->upperCamel()}\Jobs\{$obj->upperCamel()}Job;
{else}
use App\DataTransferObjects\{$obj->upperCamel()}Params;
use App\Jobs\{$obj->upperCamel()}Job;
{/if}

/**
 * 幂等性: 該程式是否可以 重覆執行, 並且有相同的結果   : yes/no
 * 重試:  該程式在工作未完成/被中斷 之後, 是否可以重試 : yes/no
 * 
 * ShouldQueue: 宣告後, 該 job 會進到 queue 之中, 以非同步來執行
 * use SerializesModels: 讓 Eloquent 模型在處理任務的時候可以被優雅地序列化和反序列化
 */
class {$obj->upperCamel()}Job implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable;
    use SerializesModels;

    /**
     * At least $tries
     */
    public int $tries = 1;
    private {$obj->upperCamel()}Params $params;

    /**
     * @param {$obj->upperCamel()}Param $params
     */
    public function __construct({$obj->upperCamel()}Params $params)
    {
        /**
         * @var string $queue, queue level see "config/horizon.php"
         */
        $this->queue = 'default';
        $this->param = $params;

        $this->dispatchBeforeValidate();
    }

    /**
     * @param {$obj->upperCamel()}Work $work
     * @throws Exception
     */
    public function handle({$obj->upperCamel()}Work $work)
    {
        // ini_set('memory_limit', '512M');

        $this->params->jobId = $this->job->getJobId();
        $work->perform($this->params);
        // $work->perform($this->params, $this);
    }

    static public function factoryParam(array $data): {$obj->upperCamel()}Params
    {
        return new {$obj->upperCamel()}Params($data);
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    protected function dispatch_example()
    {
        return;

        $params = new {$obj->upperCamel()}Params([
            'accountId' => (int) 1,
            'articleId' => (int) 1,
        ]);
        $params = {$obj->upperCamel()}Job::factoryParams([
            'accountId' => (int) 1,
            'articleId' => (int) 1,
        ]);

        if (App::environment(['local'])) {
            {$obj->upperCamel()}Job::dispatchNow($params);
        } else {
            {$obj->upperCamel()}Job::dispatch($params);
        }


        // trigger job
        if (App::environment(['local', 'geo-local'])) {
            {$obj->upperCamel()}Job::dispatchNow($params);  // try for localhost
        } else {
            $queueName = 'default'; // see "config/horizon.php"
            {$obj->upperCamel()}Job::dispatch($params);
                ->onQueue($queueName);
                ->delay(now()->addSecond(20));
        }

        // $request->session()->flash('success-message', 'Task was queue');
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
        if (! this->params->accountId) {
            throw new Exception("accountId not found");
        }
    }

    /**
     * @param string $type
     * @param string $message
     * @param array $option
     */
    /*
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
    */

}
