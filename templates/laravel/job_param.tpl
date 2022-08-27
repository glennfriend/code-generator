<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\DataTransferObjects;
{else        }namespace App\Jobs;
{/if}

use Exception;
use TypeError;

/**
 * Data Transfer Object
 * 請注意, 如果 DTO 要經過 queue, 如果參數有物件並且 serialization 失敗, job 將一直停留在 pending, 且沒有錯誤訊息
 * 沒有錯誤訊息的原因有可能是 src/Illuminate/Foundation/Exceptions/Handler.php $internalDontReport 被關閉的名單 ????
 */
class {$obj->upperCamel()}Param
{
    public ?string $jobId;

    public int $accountId;
    public ?string $status;
    /**
     * @var User[] $users
     */
    public array $users;
    

    /**
     * @param array $data
     */
    public function __construct(array $data)
    {
        $this->jobId     = isset($data['jobId']) ? (string) $data['jobId'] : null;

        $this->accountId = (int) $data['accountId'];
        $this->status    = $data['status'] ?? null;
        $this->users     = $data['users'];

        $this->typeLevelValidate();
    }

    protected function typeLevelValidate(): void
    {
        foreach ($this->users as $user) {
            if (!$userData instanceof User) {
                throw new TypeError(self::class . '::$users only allow type User[] ');
            }
        }
    }

}