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
 *  幂等性: 該 job 是否可以重覆執行, 但具有相同的結果: yes/no
 */
class {$obj->upperCamel()}Job implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable;

    public $tries = 1;

    /**
     * queue level
     *      - highest, high, default, low, lowest
     */
    public $queue = 'default';

    /**
     *
     */
    public function __construct(array $attributes)
    {
        $this->attributes = $attributes;
    }

    /**
     *
     */
    public function handle(
        {$obj->upperCamel()}Service ${$obj}Service,
        {$obj->upperCamel()}Repository ${$obj}Repository
    )
    {
        $accountId = data_get($this->attributes, 'account_id');
        $email     = data_get($this->attributes, 'email');
        $this->{$obj}Service    = ${$obj}Service;
        $this->{$obj}Repository = ${$obj}Repository;

        
        $this->log('info', "start by {ldelim}$accountId{rdelim}/{ldelim}$email{rdelim}");
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
    }

}
