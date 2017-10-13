<?php
namespace DoctrineMigrations;
use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 *
 */
class Version20000101_{$mod->upperCamel('_')} extends AbstractMigration
{

    /**
     *  Run the migrations
     *
     *  @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $sql = "DROP TABLE `{$mod->lower('_')}`";
        $this->addSql($sql);

        $sql = "CREATE TABLE ....";
        $this->addSql($sql);
    }

    /**
     *  Reverse the migrations
     *
     *  @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $sql = "DROP TABLE `{$mod->lower('_')}`";
        $this->addSql($sql);
    }

}
