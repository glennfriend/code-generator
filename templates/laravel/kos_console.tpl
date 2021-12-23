<?php
declare(strict_types=1);

{if $isModule}namespace Modules\{$obj->upperCamel()}\Console;
{else        }namespace App\Console\{$obj->upperCamel()};
{/if}

use Exception;
use Illuminate\Console\Command;

/**
 * TODO: 可以重用的部份請移出
 * 
 * 程式特性
 *      - 冪等性 (idempotent): true/false
 */
class {$obj->upperCamel()}Console extends Command
{

    /**
     * The name and signature of the console command.
     */
    protected $signature = '{$obj->lower()}:example
        {ldelim}account?{rdelim}
        {ldelim}--yes      : 不用詢問, 直接執行指令{rdelim}
        {ldelim}--file=    : (string) 指定 json file 的路徑與檔案名稱{rdelim}
    ';

    /**
     * The console command description.
     */
    protected $description = 'is a example';

    /**
     *
     */
    public function handle()
    {
        $this->validate();
        $this->help();

        // dump($this->argument('account'));
        dump($this->arguments());
        // dump($this->option('yes'));
        dump($this->options());




        $this->line('Done');
    }


    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    protected function validate()
    {
        if (!in_array(env('APP_ENV'), ['staging', 'local'])) {
            $this->line('<fg=red>Execute fail !</>');
            $this->line('  ' . 'Forbidden environment');
            exit;
        }

        /*
        if (! class_exists('Sheets')) {
            $this->line('<fg=red>Execute fail !</>');
            $this->line('  ' . 'library not found');
            $this->line('');
            $this->line('<fg=green>Tips</>');
            $this->line('  ' . 'composer require <fg=yellow>"revolution/laravel-google-sheets:3.1.0"</>');
            $this->line('');
            exit;
        }
        */

        // throw new Exception("test only");
    }

    protected function help()
    {
        $account = (string) $this->argument('account');
        if (!$account) {
            $this->showHelp();
            exit;
        }
    }

    protected function showHelp()
    {
        $prefix = '  ' . trim(explode(' ', $this->signature)[0]);

        $this->warn('Description:');
        $this->line('  '. $this->getDescription());
        $this->line('');

        $this->warn('[example] Help:');
        $this->line($prefix . ' <fg=green>--help</>');
        $this->line('');

        $this->warn('[example] Add one:');
        $this->line($prefix . ' <fg=green>--file="Resources/import/example/example_1.json"</>');
        $this->line('');

        $this->warn('[example] Direct execution without asking:');
        $this->line($prefix . ' <fg=green>--all --yes</>');
        $this->line('');
    }


}
