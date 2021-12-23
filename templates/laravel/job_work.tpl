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
use Modules\{$obj->upperCamel()}\DataTransferObjects\Works\{$obj->upperCamel()}Param;
use Modules\{$obj->upperCamel()}\Jobs\{$obj->upperCamel()}Job;
{else}
use App\DataTransferObjects\Works\{$obj->upperCamel()}Param;
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
    use ChannelLog;

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

    /**
     * @param {$obj->upperCamel()}Param $param
     * @param {$obj->upperCamel()}Job|null $job
     * @throws Exception
     */
    public function perform({$obj->upperCamel()}Param $param, {$obj->upperCamel()}Job $job = null)
    {
        $this->param = $param;
        $this->job = $job;
        $this->joblogger = $this->buildTheJoblogger();

        try {
            $this->validate();
            $this->init();
            $this->main();
        } catch (RuntimeException $exception) {
        } catch (Exception | Throwable $exception) {
        } finally {
            if (isset($exception)) {
                $message =  get_class($exception) . ": {ldelim}$exception->getMessage(){rdelim}";
                $this->log()->error($message);
                $this->joblogger->saveException($exception);
                throw $exception;
            }
        }

        $this->joblogger->complete();
    }

    /**
     * feature
     *      - 檢查必要的參數
     *      - 如果必要的參數有問題, 抓取會發生錯誤, query 出來先檢查
     *      - assign variable
     *
     * @throws Exception
     */
    private function init()
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

        $this->joblogger->appendLog($message);
        $this->joblogger->saveJoblog();
    }

    private function main()
    {
        if ($this->isFinished()) {
            $this->finished();
        } elseif ($this->isExpired()) {
            $this->timeout();
        } else {
            $this->continues();
        }
    }

    // --------------------------------------------------------------------------------
    //  check
    // --------------------------------------------------------------------------------

    private function isFinished(): bool
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

    /**
     * 計算 work/job 開始一直到限定時間, 以決定是否過期
     */
    private function isExpired(): bool
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

    // --------------------------------------------------------------------------------
    //  flow
    // --------------------------------------------------------------------------------

    private function finished()
    {
        $this->{$obj}->updated_at = now();
        $this->{$obj}->status = 'finished';
        $this->{$obj}->update();
    }

    private function continues()
    {
        $counter = $this->{$obj}->getCustom('counter') ?? 0;
        $counter++;
        $this->{$obj}->setCustom('counter', $counter);
        $this->{$obj}->save();

        if (App::environment(['local', 'geo-local'])) {
            die(__CLASS__ . ' continues to Stop for localhost');
        } else {
            {$obj->upperCamel()}Job::dispatch($this->param)
            ->onQueue('check_job')
            ->delay(
                now()->addMinutes($this->waitMinutes)
            );
        }
    }

    private function timeout()
    {
        $this->{$obj}->updated_at = now();
        $this->{$obj}->status = 'timeout';
        $this->{$obj}->update();
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     * @return Joblogger
     */
    private function buildTheJoblogger(): Joblogger
    {
        $joblogger = $this->buildJoblogger('請自行定義一個名稱');
        $joblogger->saveJob($this->job);
        $joblogger->execute();

        return $joblogger;
    }

    /**
     * @throws Exception
     */
    private function validate()
    {
        $this->param->validate();

        if (! $this->param->accountId) {
            throw new Exception('accountId not found');
        }
    }

}