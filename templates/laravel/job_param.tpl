<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\DataTransferObjects\Works;
{else        }namespace App\Jobs;
{/if}

use Exception;

/**
 * Data Transfer Object
 */
class {$obj->upperCamel()}Param
{
    /**
     * @var int
     */
    public $accountId;
    /**
     * @var string|null
     */
    public ?$status;

    /**
     * @param array $data
     */
    public function __construct(array $data)
    {
        $this->accountId = (int) $data['accountId'];
        $this->status    = (string) $data['status'] ?? null;
    }

    /**
     * @throws Exception
     */
    public function validate()
    {
        if (! $this->accountId) {
            throw new Exception("accountId not found");
        }
    }

}