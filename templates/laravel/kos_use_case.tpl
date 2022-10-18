<?php

declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\UseCases;
{else        }namespace App\UseCases;
{/if}

use App\UseCases\UseCase;
use Modules\{$obj->upperCamel()}\Entities\{$obj->upperCamel()};
use Modules\{$obj->upperCamel()}\Repositories\{$obj->upperCamel()}Repository;

/**
 *
 */
// ______UseCase extends UseCase
class Get{$obj->upperCamel()}Service
{
    protected {$obj->upperCamel()}Repository ${$obj}Repository;

    public function __construct(
        {$obj->upperCamel()}Repository ${$obj}Repository
    ) {
        $this->{$obj->upperCamel()}Repository = ${$obj}Repository;
    }

    public function perform(int ${$obj}Id): {$obj->upperCamel()}
    {
        // 請修改 -> 單一筆用 find(), 下 findWhere 才要用這個方式?
        try {
            return $this->{$obj}Repository->findWhere([
                'id' => ${$obj}Id,
            ])->firstOrFail();
        } catch (ItemNotFoundException $exception) {
            throw new ModelNotFoundException($exception->getMessage());
        }
    }
}



class about_sql_write_query
{
    public function perform()
    {
        // TODO: 未完成, 如果寫入錯誤, 應該要導出什麼 exception 才是正確的 ??
        try {
            $this->createAccountService->perform($payload);
            $this->updateAccountService->perform($payload);
        }
        catch (QueryException $exception) {
            if (ExceptionError::isForeignKeyConstraint($exception)) {
                $error = 'foreign key constraint error';
            }
            else {
                $error = 'query error';
            }
            return $this->error($error, 400, $exception);
        }
    }
}