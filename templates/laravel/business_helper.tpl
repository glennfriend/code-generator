<?php
declare(strict_types = 1);
namespace App\Service\{$obj->upperCamel()};

use ??????????

/**
 *  helper
 */
class {$obj->upperCamel()}Helper
{
    /**
     *
     */
    protected $error = null;

    /* --------------------------------------------------------------------------------

    -------------------------------------------------------------------------------- */

    /**
     *  add to cart
     */
    public function addToCart(ShopProduct $shopProduct)
    {
        $this->error = null;

        return [
            'cart_total_item_ids' => [],
            'cart_total_price'    => 0,
        ];
    }

    /**
     *
     */
    public function addNewBlog(Blog $blog)
    {
        $this->error = null;

        // model -> begin
        // add blog
        // add first article for blog
        // add first comment for firat article
        // model -> commit
    }


    /* --------------------------------------------------------------------------------

    -------------------------------------------------------------------------------- */

    /**
     *
     */
    public function getError()
    {
        return $this->error;
    }

}
