<?php
/**
 * Smarty even modifier plugin
 * 目的是為了排版讓 source code 感覺整齊
 *
 * Type:     modifier<br>
 * Name:     smarty<br>
 * Purpose:  even string.
 * Examples:
 * $string|even:20:"left":"0"
 * $string|even:20
 * $string|even:20:"right":" "
 *  
 */
function smarty_modifier_even( $string, $length=20, $way="right",  $str=' ', $len_function='mb_strlen' ){

    $length = (int) $length;
    if( strtolower($way)=='left' ) {
        $way='left';
    } else {
        $way='right';
    }

    if( strtolower($len_function)=='strlen' ) {
        if( strlen($string)>=$length ) {
            return $string;
        }
        $str_len = strlen($string);
    } else {
        if( mb_strlen($string)>=$length ) {
            return $string;
        }
        $str_len = mb_strlen($string);
    }

    $add_str = str_repeat($str,$length-$str_len);

    if($way=='left') {
        return $add_str.$string;
    } else {
        return $string.$add_str;
    }

}

?>