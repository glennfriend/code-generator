"use strict";

if ( typeof(ModelTool) == "undefined" ) {

    console.log('{$obj}.js error - please load ModelTool first');

}
else if ( typeof(ObjectTool) == "undefined" ) {

    console.log('{$obj}.js error - please load ObjectTool first');

}
else {

    var {$obj->upperCamel()}Helper =
    {
        /**
         *  取得產品中, 所有的 size, color
         *  該功能通常使用方法為 代入相同 sku 的 products, 以取得該 sku 下所有的 size, color
         *  @param array - object array
         *  @return info object or null
         */
        getInfoBy{$obj->upperCamel()}: function( objects )
        {
            if( Object.prototype.toString.call( objects ) !== '[object Array]' ) {
                return null;
            }

            var size = [];
            var color = [];
            var len = objects.length;
            for ( var i=0; i<len; i++ ) {
                size.push( objects[i].size );
                color.push( objects[i].color );
            }
            return {
                'size':  php.array_values(php.array_unique(size)),
                'color': php.array_values(php.array_unique(color))
            };
        },

    };

    /**
     *  {$obj->upperCamel()}Model
     */
    var {$obj->upperCamel()}Model = function()
    {
        var sf = this;
        sf.rows = [];

        // ============================== public ==============================
        sf.importJson = function( jsonData )
        {
            var result = ModelTool.renderByJson( jsonData );
            if ( false !== result ) {
                sf.rows = result;
            }
        };

        /**
         *  全部產品數量
         *  @return int
         */
        sf.getNum = function()
        {
            return sf.rows.length;
        };

        /**
         *  取得所有產品
         *  @return objects
         */
        sf.getAll = function()
        {
            return sf.rows;
        };

        /**
         *  取得單一產品 by index
         *  @param index
         *  @return object or null
         */
        sf.get = function(index)
        {
            if ( sf.rows[index] ) {
                return sf.rows[index];
            }
            return null;
        };

        /**
         *  取得多筆商品 by sku
         *  @param index
         *  @return object or null
         */
        sf.getManyBySku = function(sku)
        {
            var len = this.getNum();
            var objects = [];
            for ( var i=0; i<len; i++ ) {
                var obj = this.get(i);
                if ( !obj || obj.sku !== sku ) {
                    continue;
                }
                objects.push(obj);
            }
            if ( !objects || objects.length < 1 ) {
                return null;
            }
            return objects;
        }

    };

    /**
     *  {$obj->upperCamel()}Object
     */
    var {$obj->upperCamel()}Object = function ()
    {
        var _fields = [{foreach from=$tab key=key item=field}'{$field.ado->name}',{/foreach} 請做修改!! ];
        var sf = this;

        // ============================== public ==============================
        sf.init = function( jsonLine )
        {
            sf = ObjectTool.renderByJson( jsonLine );
        };

        sf.getPrice = function()
        {
            return parseFloat(sf.price);
        };

        sf.getLink = function(linkName)
        {
            return '<a href="//' + sf.urlkey  + '">'+ linkName +'</a>';
        };

        sf.getImage = function()
        {
            return '<img src="' + sf.imageUrl +'" alt="' + sf.name +'" width="50" height="50" />';
        };

        // ============================== private ==============================

    };

}
