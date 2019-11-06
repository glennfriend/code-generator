<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Migrations\Migration;

class Create{$mod->upperCamel()}View extends Migration
{
    /**
     * @var string Table name
     */
    private $tableName = '{$mod->lower('_')}';

    /**
     * Run the migrations
     */
    public function up()
    {
        $this->rebuildNewView();
    }

    /**
     * Reverse the migrations
     */
    public function down()
    {
        $this->rebuildOldView();
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     *
     */
    private function rebuildNewView()
    {
        $newQuery =<<<"EOF"
CREATE VIEW {ldelim}$this->tableName{rdelim} AS
(
    SELECT *
    FROM `$this->tableName`
    WHERE 1
)
EOF;

        //
        if (config('database.default') !== 'mysql') {
            return;
        }
        DB::statement("DROP VIEW IF EXISTS {ldelim}$this->tableName{rdelim}");
        DB::statement($newQuery);
    }

    /**
     * 如果該 view query 不是第一次建立
     * 這裡應該要建立 "上一次這個同名的 view migration" 的 view query
     */
    private function rebuildOldView()
    {
        $oldQuery = null;

        //
        if (config('database.default') !== 'mysql') {
            return;
        }
        DB::statement("DROP VIEW IF EXISTS {ldelim}$this->tableName{rdelim}");
        if (! $oldQuery) {
            return;
        }
        DB::statement($oldQuery);
    }

}
