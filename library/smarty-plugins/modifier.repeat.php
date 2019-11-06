<?php
/**
 * 印出多少重覆的值
 *
 * Type:     modifier<br>
 * Name:     smarty<br>
 * Purpose:  even string.
 * Examples:
 * $string|strlen|repeat
 * $string|strlen|repeat:'_'
 *
 */
function smarty_modifier_repeat(int $number, string $str=' ')
{
    return str_repeat($str, $number);
}

?>