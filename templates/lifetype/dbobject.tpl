<?php
    /**
     *
     *
     */
    class {$oName3}
    {
{foreach from=$vName2 item=name}
        var $_{$name};
{/foreach}

        // the method mapping model of mapRow(), 不是必填的建構子請移除
        public function {$oName3} (
{foreach $vName1 as $key => $val}
{if $val@index==0}{elseif $val@index!=($val@total)}
            ${$vName2.$key},
{else}{/if}{*    {if $val@index%5==0}{/if}    *}
{/foreach}
            $id = -1
        )
        {
            $this->DbObject();
            $this->_pk = "id";

{foreach $vName2 as $key => $val}
            $this->set{$vName3.$key}( ${$vName2.$key} );
{/foreach}

            $this->_fields = Array(
{foreach $vName3 as $key => $val}
                "{$vName5.$key}" {$vName5.$key|space_even} => "get{$vName3.$key}"{if $val@last==false},{/if}

{/foreach}
            );
        }

        //------------------------------------------------------------------------------------------------------------------------
        // basic ( properties default setting in DbObject )
        //------------------------------------------------------------------------------------------------------------------------
{foreach $vName3 as $key => $val}
{if $vName1.$key=='properties'}
        // properties
        public function getProperties()
        {
            if( !$this->_properties ) {
                $this->_properties = Array();
            }
            return $this->_properties;
        }
        public function setProperties( $properties )
        {
            $this->_properties = $properties;
        }

{elseif $fieldType.$key=='timestamp'}
        // timestamp
        public function get{$vName3.$key}()
        {
            if( !$this->_{$vName2.$key} ) {
                $t = new Timestamp();
                $this->_{$vName2.$key} = $t->getTimestamp();
            }
            return $this->_{$vName2.$key};
        }
        public function get{$vName3.$key}Object()
        {
            if( !$this->_{$vName2.$key} ) {
                $this->get{$vName3.$key}();
            }
            return new Timestamp( $this->_{$vName2.$key} );
        }
        public function set{$vName3.$key}( ${$vName2.$key} )
        {
            $this->_{$vName2.$key} = ${$vName2.$key};
        }
        public function set{$vName3.$key}Object( ${$vName2.$key}Object )
        {
            $this->_{$vName2.$key} = ${$vName2.$key}Object->getTimestamp();
        }

{else}
        public function get{$vName3.$key}()
        {
            return $this->_{$vName2.$key};
        }
        public function set{$vName3.$key}( ${$vName2.$key} )
        {
            $this->_{$vName2.$key} = ${$vName2.$key};
        }

{/if}
{/foreach}

        //------------------------------------------------------------------------------------------------------------------------
        // extends
        //------------------------------------------------------------------------------------------------------------------------
        /**
         *  use by lifetype cache
         */
        public function __sleep()
        {
            $this->_userInfo = null;
            $this->_blogInfo = null;
            return parent::__sleep();
        }

        /**
         *  get userinfo
         *  @param boolean isSave , save object or not
         *  @return object
         */
        public function getUserInfo( $isSave=true )
        {
            if( !$isSave ) {
                $this->_userInfo = null;
            }
            if( $this->_userInfo ) {
                return $this->_userInfo;
            }

            $users = new Users();
            $userInfo = $users->getUserInfoFromId( $this->getUserId() );

            if( $isSave ) {
                $this->_userInfo = $userInfo;
            }
            return $userInfo;
        }

        /**
         *  get bloginfo
         *  @param boolean isSave , save object or not
         *  @return object
         */
        public function getBlogInfo( $isSave=true )
        {
            if( !$isSave ) {
                $this->_blogInfo = null;
            }
            if( $this->_blogInfo ) {
                return $this->_blogInfo;
            }

            $blogs = new Blogs();
            $blogInfo = $blogs->getBlogInfo( $this->getBlogId() );

            if( $isSave ) {
                $this->_blogInfo = $blogInfo;
            }
            return $blogInfo;
        }

    }

/*
    $this->_topic = $topic;
    $this->_normalizedTopic = Textfilter::normalizeText( $topic );
*/

?>