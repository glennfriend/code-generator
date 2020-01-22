<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Create{$mod->upperCamel()} extends Migration
{

    /**
     * Run the migrations
     */
    public function up()
    {
        if (Schema::hasTable('{$mod->lower('_')}')) {
            // exists
            return;
        }

        Schema::table('{$mod->lower('_')}', function (Blueprint $table) {
            $this->createTable();
            // $this->changeTable();
            // $this->createDataFromSql();
        });
    }

    /**
     * Reverse the migrations
     */
    public function down()
    {
        // $sql = 'DROP TABLE `{$mod->lower('_')}`';
        // Schema::dropIfExists('{$mod->lower('_')}');
        // Schema::dropIfExists('{$mod->lower('_')}');
        /*
        Schema::table('{$mod->lower('_')}', function (Blueprint $table) {
            $table->dropColumn('__the_field_name__');
        });
        */
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     *
     */
    private function changeTable()
    {
        Schema::create('{$mod->lower('_')}', function (Blueprint $table) {
            $table->index('account_id');
            $table->dropIndex('account_id');
        });
    }

    /**
     *
     */
    private function createTable()
    {
        // 是依照 name, type 的一般建議方式建立, "不是" 依照資料表的欄位屬性 (TODO: delete it)
        Schema::create('{$mod->lower('_')}', function (Blueprint $table) {
{foreach from=$tab key=key item=field}
{if $key=='id'}
            $table->bigIncrements('id');
{elseif $key=='status' && $field.ado->type=='enum'}
            $table->enum('{$field.ado->name}', ['enable', 'disable']);
{elseif $key=='status'}
            $table->string('{$field.ado->name}')->unsigned()->index('{$field.ado->name}');
{elseif $key=='createdAt'}
            $table->timestamp('{$field.ado->name}');
{elseif $key=='updatedAt' || $key=='deletedAt'}
            $table->timestamp('{$field.ado->name}')->nullable();
{elseif $key=='properties' || $key=='attribs'}
            $table->text('{$field.ado->name}');
{elseif $field.ado->type=='tinyint'}
            $table->tinyInteger('{$field.ado->name}')->unsigned()->index('{$field.ado->name}');
{elseif $field.ado->type=='smallint'}
            $table->smallInteger('{$field.ado->name}')->unsigned()->nullable();
{elseif $field.ado->type=='int'}
            $table->integer('{$field.ado->name}')->unsigned()->nullable();
{elseif $field.ado->type=='bigint'}
            $table->bigInteger('{$field.ado->name}')->unsigned()->nullable();
{elseif $field.ado->type=='float'}
            $table->float('{$field.ado->name}', 8, 2);
{elseif $field.ado->type=='decimal'}
            $table->unsignedDecimal('{$field.ado->name}', 8, 2);
{elseif $field.ado->type=='varchar'}
            $table->string('{$field.ado->name}', 100)->nullable()->index('{$field.ado->name}');
{elseif $field.ado->type=='text'}
            $table->text('{$field.ado->name}')->nullable();
{elseif $field.ado->type=='mediumtext'}
            $table->mediumText('{$field.ado->name}')->nullable();
{elseif $field.ado->type=='timestamp'}
            $table->timestamp('{$field.ado->name}');
{elseif $field.ado->type=='datetime' || $field.ado->type=='date'}
            $table->timestamp('{$field.ado->name}');    // {$field.ado->type}
{elseif $field.ado->type=='enum'}
            $table->enum('{$field.ado->name}', ['type1', 'type2']);
{else}
            $table->string('{$field.ado->name}', 255)->nullable();
{/if}
{/foreach}

            $table->engine = 'InnoDB';
        });

        #
        #   請用 phpmyadmin dump
        #       - "http://localhost/phpmyadmin/tbl_export.php?single_table=true&db={SessionManager::database()}&table={$tableName->lower('_')}"
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
        DB::connection()->getPdo()->exec($sql);
    }

    /**
     *
     */
    private function changeTable()
    {
        /*
        // 追加欄位
        Schema::table('{$mod->lower('_')}', function (Blueprint $table) {
            $table->bigInteger('__the_field_name__')
                ->unsigned()
                ->nullable()
                ->index()
                ->after('id');
        });
        */
        

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
        DB::connection()->getPdo()->exec($sql);
    }

    /**
     *
     */
    private function createDataFromSql()
    {
        $sql = <<<EOD

            INSERT INTO `{$mod->lower('_')}` (....) VALUES (....);
            INSERT INTO `{$mod->lower('_')}` (....) VALUES (....);

EOD;
        DB::connection()->getPdo()->exec($sql);
    }

}
