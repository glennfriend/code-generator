<?php
/**
 * Smarty space even modifier plugin
 * 目的是為了排版讓 source code 感覺整齊
 *
 * Type:     modifier<br>
 * Name:     smarty<br>
 * Purpose:  even string.
 * Examples:
 * $string|space_even:20:"left":"0"
 * $string|space_even:20
 * $string|space_even:20:"right":" "
 *
 */
function smarty_modifier_space_even( $string, $length=20, $str=' ', $len_function='strlen' ){

    $length = (int) $length;

    if( strtolower($len_function)=='strlen' ) {
        $string = str_repeat(" ",strlen($string));
    } else {
        $string = str_repeat(" ",mb_strlen($string));
    }
    $str_len = strlen($string);

    if( $string > $length ) {
        return '';
    } else {
        if( $length-$str_len > 0 ) {
            return str_repeat($str,$length-$str_len);
        } else {
            return '';
        }
    }

}

?>