<?php
/*
    portable declarative data dictionary format in ADOdb
    使用 ADOdb 自訂義的方式來轉化成 mysql

*/
//--------------------------------------------------------------------------------
// kernel
//--------------------------------------------------------------------------------
include_once('config/config.inc.php');
include_once('library/helper.php');

session_start();
if ( !sessionCheck() ) {
    header('location: session_control.php');
    exit;
}

$projectKey = $_SESSION['projectKey'];
$objectName = $_SESSION['useObject'];
$daoName    = $_SESSION['useDao'];
$table      = $_SESSION['useTable'];

$db = getDbConnect( $config['database'] , $_SESSION['projectDb'] );
$tables = $db->MetaTables();

//--------------------------------------------------------------------------------
// request
//--------------------------------------------------------------------------------


//--------------------------------------------------------------------------------
// function 
//--------------------------------------------------------------------------------
function shortType( $col ) {
    switch(strtolower(trim($col->type))) {
        case "int": 
        case "tinyint": 
        case "smallint":
            $unsigned  = null;
            if( $col->unsigned ) {
                $unsigned = " UNSIGNED";
            }
            return "I(". $col->max_length .")". $unsigned;
        case "float": 
            return "F";
        case "timestamp": 
            return "T(14)";
        case "datetime": 
            return "DATETIME";
        case "date": 
            return "DATE";
        case "varchar":
        case "char":
            return "C(". $col->max_length .")";
        case "smalltext":
        case "text":
            return "TEXT";
        case "longtext":
            return "X2";
        default:
            return $type."(". $col->max_length .")";
    }
}

function shortNotNull( $col ) {
    if($col->not_null) {
        return "NOTNULL ";
    }
}

function shortDefaultValue( $col ) {

    if($col->has_default) {
        switch( strtolower(trim($col->type))) {
            case "timestamp": 
            case "datetime": 
            case "date": 
                if(!$col->not_null) {
                    return "DEFAULT NULL ";
                }
                else {
                    // 這裡不準確, 請想辦法修改
                    if( 'CURRENT_TIMESTAMP' != $col->default_value ) {
                        return "DEFAULT '". $col->default_value."' ";
                    }
                    return "";
                }
            default:
                return "DEFAULT '". $col->default_value."' ";
        }
    }

    if(!$col->not_null) {
        return "DEFAULT NULL ";
    }

}

function shortAutoId( $col ) {
    if( $col->primary_key && $col->auto_increment ) {
        return "AUTOINCREMENT PRIMARY";
    }
}

function shortIndexType( $ix, $allColumns ) {
    if( $ix['unique']==1 ) {
        return "UNIQUE";
    }

    // 在索引的訂義中, 如果欄位全為 text, 請設定為 FULLTEXT "全文檢索" 的索引方式
    $isFieldsAllText = true;
    foreach( $ix['columns'] as $fieldName ) {
        foreach( $allColumns as $column ) {
            if( $fieldName == $column->name ) {
                if( 'text'==$column->type ) {
                    //
                }
                else {
                    $isFieldsAllText = false;
                }
            }
        }
    }
    if( $isFieldsAllText ) {
        return "FULLTEXT";
    }

    return "INDEX";
}

function shortIndexColumns( $ix ) {
    $str = '';
    foreach( $ix['columns'] as $column ) {
        if($str) {
            $str .= ', '.$column;
        }
        else {
            $str = $column;
        }
    }
    return '('.$str.')';
}


//--------------------------------------------------------------------------------
// output
//--------------------------------------------------------------------------------
headerOutput();

echo '<pre style="background-color:#def;color:#000;text-align:left;font-size:8px;font-family:dina,GulimChe;">';


foreach( $tables as $table ) {

    /* if( $table!='plog_blog'.'host_blocking_rules' ) {
        continue;
    } */

    $output = '';
    $columns = $db->MetaColumns( $table );
    $indexs = $db->MetaIndexes( $table );

    foreach( $columns as $col ) {
        $tmp 
           = $col->name." "
           . shortType($col)
           . " "
           . shortNotNull($col)
           . shortDefaultValue($col)
           . shortAutoId($col)
        ;
        $output .= '  '.trim($tmp).",\n";
    }

    foreach( $indexs as $keyName => $ix ) {
        $tmp
           = shortIndexType( $ix, $columns )." "
           . $keyName." "
           . shortIndexColumns($ix)
        ;
        $output .= '  '.trim($tmp).",\n";
    }

    $output = trim($output);
    if( substr($output,-1,1)==',' ) {
        $output = '  '.substr($output,0,strlen($output)-1);
    }

    echo "\n(".$table.")\n";
    echo $output."\n\n";

    //print_r($columns);
    //print_r($indexs);

}

echo "</pre>\n";


/*
$tabname = 'table_name';
$options["mysql"] = "TYPE=MyISAM";

$dict = NewDataDictionary($db);
$fields = " 
  id I(10) UNSIGNED NOTNULL AUTOINCREMENT PRIMARY,
  date T(14) NOTNULL,
  user_id I(10) UNSIGNED NOTNULL DEFAULT '0',
  blog_id I(10) UNSIGNED NOTNULL DEFAULT '0',
  num_reads I(10) DEFAULT '0',
  properties TEXT NOTNULL DEFAULT '',
  status I(5) NOTNULL DEFAULT 1,
  slug C(255) NOTNULL DEFAULT '',
  modification_date T(14) NOTNULL,
  num_comments I(10) NOTNULL DEFAULT '0', 
  num_nonspam_comments I(10) NOTNULL DEFAULT '0', 
  num_trackbacks I(10) NOTNULL DEFAULT '0',
  num_nonspam_trackbacks I(10) NOTNULL DEFAULT '0',
  global_category_id I(10) NOTNULL DEFAULT '0',
  in_summary_page I1(1) NOTNULL DEFAULT '1',
  loc_id I(10) NOTNULL DEFAULT '0'

";


# We demonstrate creating tables and indexes
echo '<pre style="background-color:#def;color:#000;text-align:left;font-size:10px;font-family:dina,GulimChe;">';
print_r( $fields );
print_r( $dict->CreateTableSQL($tabname, $fields, $taboptarray) );
//print_r( $dict->AlterColumnSQL($tabname, $fields, $taboptarray) );
//$idxflds = 'username, email';
//print_r( $dict->CreateIndexSQL($tabname, $tabname, $idxflds) );
echo "</pre>\n";
*/

//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
//