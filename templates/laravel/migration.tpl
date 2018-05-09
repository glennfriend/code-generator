<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

/**
 *
 */
class {$mod->upperCamel()}Table extends Migration
{

    /**
     * Run the migrations
     */
    public function up()
    {
        Schema::table(null, function(Blueprint $table) {
            // $sql = $this->createTableSql();
            // $sql = $this->changeTableSql();
            // $sql = $this->createDataSql();
            DB::connection()->getPdo()->exec($sql);
        });
    }

    /**
     * Reverse the migrations
     */
    public function down()
    {
        // $sql = 'DROP TABLE `{$mod->lower('_')}`';
        Schema::drop('{$mod->lower('_')}');
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     *
     */
    protected function createTableSql()
    {
        #
        #   請用 phpmyadmin dump
        #       - "http://localhost/phpmyadmin/tbl_export.php?single_table=true&db={getDatabase()}&table={$tableName->lower('_')}"
        #       - SQL schema
        #       - 索引
        #       - ENGINE=InnoDB
        #       - DEFAULT CHARSET=utf8mb4
        #       - AUTO_INCREMENT 無序號
        #

        $table = '{$mod->lowerCamel('_')}';
        $sql =<<<EOD
CREATE TABLE IF NOT EXISTS `{ldelim}$table{rdelim}` (
  `id` int(10) UNSIGNED NOT NULL,
  ....
  ....
  ....
  ....
  `properties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `{ldelim}$table{rdelim}`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `{ldelim}$table{rdelim}`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

EOD;

        return $sql;
    }

    /**
     *
     */
    protected function changeTableSql()
    {
        /*
            變更 varchar 欄位
                ALTER TABLE `{$mod->lower('_')}`
                    CHANGE `email` `email` VARCHAR(120) CHARACTER SET utf8 COLLATE utf8mb4_general_ci NOT NULL;

            在 email 欄位之後新增 type 欄位
                ALTER TABLE `{$mod->lower('_')}`
                    ADD `type` INT UNSIGNED NOT NULL
                    AFTER `email`;

            刪除 type 欄位
                ALTER TABLE `{$mod->lower('_')}`
                    DROP COLUMN type;

            create index
                ALTER TABLE `{$mod->lower('_')}`
                    ADD INDEX(`type`);

            remove index
                ALTER TABLE `{$mod->lower('_')}`
                    DROP INDEX(`type`);

        */
        $sql = <<<EOD

            ALERT TABLE ......

EOD;
        return $sql;
    }

    /**
     *
     */
    protected function createDataSql()
    {
        $sql = <<<EOD

            INSERT INTO `{$mod->lower('_')}` (....) VALUES (....);
            INSERT INTO `{$mod->lower('_')}` (....) VALUES (....);

EOD;
        return $sql;
    }

}
