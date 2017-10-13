<?php
    /**
     *
     */
    class {$oName3} extends BaseModel
    {ldelim}

{foreach $vName5 as $key => $val}
{if $fieldType.$key=='tinyint'}
        CONST {$vName4.$key}_ALL        = -1;
        CONST {$vName4.$key}_OPEN       = 1;
        CONST {$vName4.$key}_CLOSE      = 2;
        CONST {$vName4.$key}_DELETE     = 9;

{else}
{/if}
{/foreach}

{foreach from=$vName2 item=name}
        protected $_{$name};
{/foreach}

        /**
         *  讀取資料表而產生, 請視同cache, 任何情況下皆不可更動該產生的內容
         *  @return Array()
         */
        public static function getTableDefinition()
        {ldelim}
            return Array(
{foreach from=$status key=key item=field}
                '{$key}' => Array(
                    'name'           => '{$field->name}',
                    'type'           => '{$field->type}',
                    'length'         => {$field->max_length},
{if $field->unsigned}
                    'unsigned'       => TRUE,
{else}
                    'unsigned'       => FALSE,
{/if}
{if $field->primary_key}
                    'primary'        => TRUE,
{else}
                    'primary'        => FALSE,
{/if}
{if $field->not_null}
                    'notNull'        => TRUE,
{else}
                    'notNull'        => FALSE,
{/if}
{if $field->has_default}
                    'defaultValue'   => '{$field->default_value}',
{else}
                    'defaultValue'   => NULL,
{/if}
{if $field->auto_increment}
                    'autoIncrement'  => TRUE,
{else}
                    'autoIncrement'  => FALSE,
{/if}
                )
{/foreach}
            );
        {rdelim}

        /**
         *  經資料表傳至程式中時所對應的 method 資訊
         *  @return Array()
         */
        public static function getTableFields()
        {ldelim}
            return Array(
{foreach $vName3 as $key => $val}
{if $fieldType.$key=='timestamp' || $fieldType.$key=='datetime' || $fieldType.$key=='date'}
                "{$vName5.$key}" {$vName5.$key|space_even} => "get{$vName3.$key}ByDb"{if $val@last==false},{/if}
{else}
                "{$vName5.$key}" {$vName5.$key|space_even} => "get{$vName3.$key}"{if $val@last==false},{/if}
{/if}

{/foreach}
            );
        {rdelim}

        /**
         *  reset to default value model
         *  @return Array()
         */
        public function resetValue() {ldelim}
            $this->__sleep();
{foreach $vName5 as $key => $val}
{if $val=='id'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( -1 );
{elseif $val=='status'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( {$oName3}::{$vName4.$key}_OPEN );
{elseif $val=='properties'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( Array() );
{elseif $status.$val->type=='tinyint'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( {$oName3}::{$vName4.$key}_?????? );
{elseif $fieldType.$key=='int' || $status.$val->type=='smallint'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( 0 );
{elseif $fieldType.$key=='varchar' || $status.$val->type=='text'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( NULL );
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='datetime' || $fieldType.$key=='date'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( time() );
{else}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( ?????? );
{/if}
{/foreach}
        {rdelim}

        /**
         *  validate model data
         *  @return messages Array()
         */
        public function validate()
        {ldelim}
            $validateInfo = parent::validate();

{foreach $vName5 as $key => $val}
{if $val=='name'}
            if( !$this->getName() ) {
                $validateInfo['name']['message'] = '不能空值';
            }

{elseif $val=='email'}
            // email
            $result = filter_var( $this->getEmail(), FILTER_VALIDATE_EMAIL );
            if(!$result) {
                $validateInfo['email']['message'] = 'Email 格式不正確';
            }

{elseif $fieldType.$key=='tinyint'}
            // choose value
            $result = false;
            foreach( $this->get{$vName3.$key}List('{$val}') as $name => $id ) {
                if( $this->get{$vName3.$key}()==$id ) {
                    $result = true;
                    break;
                }
            }
            if(!$result) {
                $validateInfo['{$val}']['message'] = '{$val} 不正確';
            }

{elseif $val=='properties'}
{elseif $fieldType.$key=='int' || $fieldType.$key=='smallint'}
{elseif $fieldType.$key=='varchar' || $fieldType.$key=='text'}
{elseif $fieldType.$key=='timestamp'}
            // timestamp
            if( $this->get{$vName3.$key}() < -28800 ) {
                $validateInfo['{$vName2.$key}']['message'] = '日期不正確';
            }

{elseif $fieldType.$key=='date' || $fieldType.$key=='datetime'}
{else}
{/if}
{/foreach}
            return $validateInfo;
        {rdelim}

        /**
         *  filter model data
         */
        public function filter()
        {ldelim}
{foreach $vName5 as $key => $val}
{if $val=='id'}
{elseif $val=='properties'}
{elseif $fieldType.$key=='int' || $status.$val->type=='tinyint' || $status.$val->type=='smallint'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( (int) $this->get{$vName3.$key}() );
{elseif $fieldType.$key=='varchar' || $status.$val->type=='text'}
            $this->set{$vName3.$key}{$vName3.$key|space_even} ( trim(strip_tags( $this->get{$vName3.$key}(){$vName3.$key|space_even} )) );
{else}
          //$this->set{$vName3.$key}{$vName3.$key|space_even} ();
{/if}
{/foreach}
        {rdelim}

        /* ------------------------------------------------------------------------------------------------------------------------
            basic method
        ------------------------------------------------------------------------------------------------------------------------ */

{foreach $vName5 as $key => $val}
{if $vName5.$key=='id'}
{elseif $vName5.$key=='properties'}
{elseif $vName5.$key=='create_date'}
{elseif $vName5.$key=='update_date'}
{elseif $fieldType.$key=='timestamp' || $fieldType.$key=='date' || $fieldType.$key=='datetime'}
        /**
         *  set {$vName2.$key}
         *  @param int , date int
         */
        function set{$vName3.$key}($int)
        {
            $this->_{$vName2.$key} = (int) $int;
        }
        /**
         *  get {$vName2.$key}
         *  @return int;
         */
        function get{$vName3.$key}()
        {
            if( !$this->_{$vName2.$key} ) {
                $this->_{$vName2.$key} = time();
            }
            return $this->_{$vName2.$key};
        }
        /**
         *  get {$vName2.$key} by format
         *  @param  format , date format string
         *  @return string
         */
        function get{$vName3.$key}ByFormat( $format="Y-m-d" )
        {
            return date($format,$this->get{$vName3.$key}());
        }
        /**
         *  convert object-value to database
         *  依照資料表欄位的格式不同, 餵給所需的格式
         *  @return string
         */
        function get{$vName3.$key}ByDb()
        {
            // "{$fieldType.$key}"
{if $fieldType.$key=='date'}
            return date("Y-m-d",$this->get{$vName3.$key}());
{else}
            return date("Y-m-d H:i:s",$this->get{$vName3.$key}());
{/if}
        }
{elseif $fieldType.$key=='int' || $fieldType.$key=='tinyint' || $fieldType.$key=='smallint'}
        /**
         *  get {$vName3.$key}
         *  @return int
         */
        public function get{$vName3.$key}()
        {ldelim}
            return $this->_{$vName2.$key};
        {rdelim}
        /**
         *  set {$vName3.$key}
         */
        public function set{$vName3.$key}( ${$vName2.$key} )
        {ldelim}
            $this->_{$vName2.$key} = (int) ${$vName2.$key};
        {rdelim}
{else}
        /**
         *  get {$vName3.$key}
         *  @return string
         */
        public function get{$vName3.$key}()
        {ldelim}
            return $this->_{$vName2.$key};
        {rdelim}
        /**
         *  set {$vName3.$key}
         */
        public function set{$vName3.$key}( ${$vName2.$key} )
        {ldelim}
            $this->_{$vName2.$key} = trim(${$vName2.$key});
        {rdelim}
{/if}

{/foreach}

        /* ------------------------------------------------------------------------------------------------------------------------
            extends
        ------------------------------------------------------------------------------------------------------------------------ */
        /**
         *  clear extends information
         */
        public function __sleep()
        {ldelim}
            $this->_user = null;
            return parent::__sleep();
        {rdelim}

        /**
         *  get user model ( 資料表必須要提供 user_id 欄位 )
         *  @param isSave 是否儲存取得的物件
         *  @return object
         */
        public function getUser( $isSave=true )
        {ldelim}
            if( !$isSave ) {ldelim}
                $this->_user = null;
            {rdelim}
            if( $this->_user ) {ldelim}
                return $this->_user;
            {rdelim}

            $users = new Users();
            $user = $users->getUser( $this->getUserId() );

            if( $isSave ) {ldelim}
                $this->_user = $user;
            {rdelim}
            return $user;
        {rdelim}

    {rdelim}

