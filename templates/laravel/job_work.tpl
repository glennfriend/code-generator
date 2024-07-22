<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Jobs;
{else        }namespace App\Jobs;
{/if}

use Exception;
use Throwable;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Log;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Modules\{$obj->upperCamel()}\Utility\Log\Concerns\ChannelLog;

{if $isModule}
use Modules\{$obj->upperCamel()}\DataTransferObjects\{$obj->upperCamel()}Params;
use Modules\{$obj->upperCamel()}\Jobs\{$obj->upperCamel()}Job;
{else}
use App\DataTransferObjects\Works\{$obj->upperCamel()}Params;
use App\Jobs\{$obj->upperCamel()}Job;
{/if}

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
 * flow example:
 *      Route/ConsoleCommand/Event
 *          -> Enter
 *          -> Job(Param)
 *          -> Work(Param)
 * 
 */
class {$obj->upperCamel()}Work
{
    protected {$obj->upperCamel()}Params $params;

    /**
     * @var {$obj->upperCamel()}|null {$obj}
     */
    private ?${$obj};

    /**
     * 
     */
    public function __construct(
        {$obj->upperCamel()}Service ${$obj}Service,
        {$obj->upperCamel()}Repository ${$obj}Repository
    )
    {
        // set_time_limit(30);
        ini_set('memory_limit', '512M');

        $this->{$obj}Service    = ${$obj}Service;
        $this->{$obj}Repository = ${$obj}Repository;
    }

    public function perform({$obj->upperCamel()}Params $params): void
    {
        $this->params = $params;

        try {
            $this->init();
            $this->validateParameters();
            $this->main();      // TODO: main 改成明顯的意圖名稱
        } catch (RuntimeException $exception) {
        } catch (Exception | Throwable $exception) {
        } finally {
            if (isset($exception)) {
                Log::error($exception->getMessage(), [
                    'category'  => '{$obj->upperCamel()}Work',
                    'exception' => get_class($exception),
                    'jobId'     => $this->params->jobId,
                ]);
                throw $exception;
            }
        }
    }

    protected function main(): void
    {
        $accountId = this->params->accountId;
 
        $this->{$obj} = $this->{$obj}Repository->getById($accountId);
        if (!$this->{$obj}) {
            throw new Exception("{$obj} not found");
        }
 
        $message = "job start accountId={ldelim}$accountId{rdelim}";
        $this->log()->debug($message, [
            'account_id' => $accountId,
        ]);
 

        
        /*
        // 原本舊的寫法
        if ($this->isExpired()) {
            $this->timeout();
        } elseif ($this->processing()) {
            $this->finished();
        } else {
            $this->retry();
        }
        */

        if ($this->isExpired()) {
            $this->timeout();
            return;
        }
        
        try {
            // TODO: 改成明顯的意圖名稱
            $this->processing();
        } catch (Exception $exception) // 應該是改成某些特定的 exception
            // 某些情況下想要 retry
            $this->retry();
        }

    }

    // --------------------------------------------------------------------------------
    //  flow
    // --------------------------------------------------------------------------------
    protected function processing(): bool
    {
        if ($this->{$obj}->status === 'finished') {
            return true;
        }
        elseif ($this->{$obj}->finished_at) {
            return true;
        }

        $accountId = $this->param->accountId;
        
        // TODO: something

        return false;
    }

    protected function finished(): void
    {
        $this->{$obj}->updated_at = now();
        $this->{$obj}->status = 'finished';
        $this->{$obj}->update();
    }

    /**
     * 計算 work/job 開始一直到限定時間, 以決定是否過期
     */
    protected function isExpired(): bool
    {
        $workStartedTime = strtotime($this->{$obj}->started_at);
        $limitTime = $workStartedTime + $this->timeoutSeconds;
        $current = time();

        if ($current > $limitTime) {
            // 超過預期的時間
            return true;
        }

        return false;
    }

    protected function timeout(): void
    {
        $this->{$obj}->updated_at = now();
        $this->{$obj}->status = 'timeout';
        $this->{$obj}->update();
    }

    protected function retry(): void
    {
        $counter = $this->{$obj}->getCustom('counter') ?? 0;
        $counter++;
        $this->{$obj}->setCustom('counter', $counter);
        $this->{$obj}->save();

        // if (App::environment(['local', 'testing', 'geo-local'])) {
        //     die(__CLASS__ . ' localhost retry to Stop for debug only');
        // }

        // 延遲執行會在 QUEUE_DRIVER=redis 的情況下會生效
        {$obj->upperCamel()}Job::dispatch($this->params)
            ->onQueue('default')  // highest, high, default, low, lowest
            ->delay(
                now()->addMinutes($this->waitMinutes)
            );
    }

    /**
     * feature
     *      - 檢查必要的參數
     *      - 如果必要的參數有問題, 抓取會發生錯誤, query 出來先檢查
     *      - assign variable
     *
     * @throws Exception
     */
    protected function init(): void
    {
        $accountId = this->param->accountId;

        $this->{$obj} = $this->{$obj}Repository->getById($accountId);
        if (!$this->{$obj}) {
            throw new Exception("{$obj} not found");
        }

        $message = "job start accountId={ldelim}$accountId{rdelim}";
        $this->log()->debug($message, [
            'account_id' => $accountId,
        ]);
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     * @throws Exception
     */
    protected function validateParameters(): void
    {
        if (! $this->params->accountId) {
            throw new Exception('accountId not found');
        }
    }

}