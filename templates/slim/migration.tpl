<?php
namespace DoctrineMigrations;
use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 *
 */
class Version{$today}_{$mod->upperCamel('_')} extends AbstractMigration
{

    /**
     *  Run the migrations
     */
    public function up(Schema $schema)
    {
        $this->createTable();
        $this->changeTable();
        $this->createData();
    }

    /**
     *  Reverse the migrations.
     */
    public function down(Schema $schema)
    {
        $sql = 'DROP TABLE `{$mod->lower('_')}`';
        $this->addSql($sql);
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

    /**
     *
     */
    private function createTable()
    {
        $sql = <<<EOD

請用 phpmyadmin dump
    - "http://localhost/phpmyadmin/tbl_export.php?db={ldelim}$database{rdelim}&table={ldelim}$tableName{rdelim}"
    - SQL schema
    - 索引
    - ENGINE=InnoDB
    - DEFAULT CHARSET=utf8mb4
    - AUTO_INCREMENT 無序號

EOD;
        $this->addSql($sql);
    }

    /**
     *
     */
    private function changeTable()
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
        $this->addSql($sql);
    }

    /**
     *
     */
    private function createData()
    {
        $sql = <<<EOD

            INSERT INTO `{$mod->lower('_')}` (....) VALUES (....);
            INSERT INTO `{$mod->lower('_')}` (....) VALUES (....);

EOD;
        $this->addSql($sql);
    }

}
