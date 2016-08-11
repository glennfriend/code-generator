<?php

class TemplateManager
{
    /**
     *
     */
    public function __construct($menu)
    {
        $this->projectKey   = $_SESSION['projectKey'];
        $this->objectName   = $_SESSION['useObject'];
        $this->daoName      = $_SESSION['useDao'];
        $this->table        = $_SESSION['useTable'];
        $this->db           = getDbConnect();
        // get meta columns
        $this->status       = getTableColumnsStatus();
        $this->menu         = $menu;

        $config = includeConfig();
        $base = $config['base'];

        // smarty
        $this->smarty = new Smarty;
        $this->smarty->debugging        = false;
        $this->smarty->caching          = false;
        $this->smarty->cache_lifetime   = 0;
        $this->smarty->compile_dir      = "{$base}/tmp/";
        $this->smarty->cache_dir        = "{$base}/tmp/template_cache/";
        $this->smarty->setTemplateDir("{$base}/templates");
        $this->smarty->addPluginsDir("{$base}/library/smarty-plugins");
      //$this->smarty->left_delimiter  = '{';
      //$this->smarty->right_delimiter = '}';

        // 不要快取 template
        $this->smarty->clearCompiledTemplate();


        $this->smarty->assign('tableName',  $this->table    );
        $this->smarty->assign('cf',         $this->menu     );
    }

    /**
     *
     */
    public function genSmarty()
    {
        // variable setting
        include('templates/'. $this->projectKey .'/_core.php');
        assingTemplate($this->smarty);
        return $this->smarty;
    }

}
