<?php
namespace App\Business\{$obj->upperCamel()};

use ??????????

/**
 *  helper
 */
class {$obj->upperCamel()}Helper
{
    /**
     *
     */
    protected static $error = null;

    // --------------------------------------------------------------------------------
    //
    // --------------------------------------------------------------------------------

    /**
     *  add to cart
     */
    public static function addToCart(ShopProduct $shopProduct)
    {
        self::$error = null;

        return [
            'cart_total_item_ids' => [],
            'cart_total_price'    => 0,
        ];
    }

    /**
     *
     */
    public static function addNewBlog(Blog $blog)
    {
        self::$error = null;

        // model -> begin
        // add blog
        // add first article for blog
        // add first comment for firat article
        // model -> commit
    }


    // --------------------------------------------------------------------------------
    //
    // --------------------------------------------------------------------------------

    /**
     *
     */
    public static function getError()
    {
        return self::$error;
    }

}
