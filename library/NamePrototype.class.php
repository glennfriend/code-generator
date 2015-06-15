<?php
/*
    分析整理程式碼字串的輔助工具
    參數的分離字元請使用 空白 or 下底線
    也支援 駝峰式 字串分離

    $nameObject = new NamePrototype('books_admin');
    $nameObject = new NamePrototype('books admin');
    $nameObject = new NamePrototype('booksAdmin');

    $oName1 = $nameObject->lower();             = 'booksadmin';   // 全小寫
    $oName2 = $nameObject->lowerCamel();        = 'booksAdmin';   // 開頭小寫 (駝峰式)
    $oName3 = $nameObject->upperCamel();        = 'BooksAdmin';   // 開頭大寫
    $oName4 = $nameObject->upper();             = 'BOOKSADMIN';   // 全大寫
    $oName5 = $nameObject->lower('_');          = 'books_admin';  // (帶底線) 全小寫
    $oName6 = $nameObject->upperCamel('_');     = 'Books_Admin';  // (帶底線) 開頭大寫
    $oName7 = $nameObject->upper('_');          = 'BOOKS_ADMIN';  // (帶底線) 全大寫
*/

class NamePrototype
{

    protected $_string;

    /**
     *  @param $string, 分離字元參數 可以使用
     *      space 空白 " "
     *      underline 下底線符號 "_" 
     *      也支援 駝峰式 字串分離 "helloWorld" 
     */
    public function NamePrototype( $str )
    {
        $str = str_replace('_', ' ', $str );
        // 駝峰式分離: "aaaBbbCcc" => "aaa bbb ccc"
        $str = preg_replace("/(?<=\\w)(?=[A-Z])/"," $1", $str );
        // 字串最後將以 '_' 符號為分隔方式
        $str = trim( $str );
        $str = preg_replace('!\s+!', ' ', $str );
        $str = str_replace(' ', '_', $str );
        $this->_string = strtolower($str);
    }

    /**
     *  將格式轉為 array
     */
    protected function _getArray()
    {
        return explode('_' , $this->_string );
    }    

    /**
     *  一律轉為小寫
     *  @param $to - 分隔使用的字串
     */
    public function lower( $to='' )
    {
        return str_replace( '_', $to, $this->_string );
    }

    /**
     *  駝峰式開頭小寫 
     *  @param $to - 分隔使用的字串
     */
    public function lowerCamel( $to='' )
    {
        $data = '';
        foreach( $this->_getArray() as $number => $name ) {
            if( $number==0 ) {
                $data .= $name;
            }
            else {
                $data .= $to . ucwords($name);
            }
        }
        return $data;
    }

    /**
     *  駝峰式開頭大寫
     *  @param $to - 分隔使用的字串
     */
    public function upperCamel( $to='' )
    {
        $data = '';
        foreach( $this->_getArray() as $number => $name ) {
            if ( $number==0 ) {
                $data .= ucwords($name);
            }
            else {
                $data .= $to . ucwords($name);
            }
        }
        return $data;
    }

    /**
     *  一律轉為大寫
     *  @param $to - 分隔使用的字串
     */
    public function upper( $to='' )
    {
        return str_replace( '_', $to, strtoupper($this->_string) );
    }

    /* ------------------------------------------------------------------------------------------------------------------------
        建立 getter setter 使用的方式
    ------------------------------------------------------------------------------------------------------------------------ */

    public function get()
    {
        $data = '';
        foreach( $this->_getArray() as $number => $name ) {
            if ( $number==0 ) {
                $data .= 'get' . ucwords($name);
            }
            else {
                $data .= ucwords($name);
            }
        }
        return $data;
    }

    public function set()
    {
        $data = '';
        foreach( $this->_getArray() as $number => $name ) {
            if ( $number==0 ) {
                $data .= 'set' . ucwords($name);
            }
            else {
                $data .= ucwords($name);
            }
        }
        return $data;
    }

    /* ------------------------------------------------------------------------------------------------------------------------
        方便 code generator 在 smarty 的使用
    ------------------------------------------------------------------------------------------------------------------------ */

    public function __toString()
    {
        return $this->lowerCamel();
    }

}

//