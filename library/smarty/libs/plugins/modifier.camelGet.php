<?php

/**
 *  為一個 變數名稱 做大小寫的轉換
 *  詳情請參考 NamePrototype class
 */
function smarty_modifier_camelGet( $string )
{
    $obj = new NamePrototype($string);
    return $obj->get();
}

?>