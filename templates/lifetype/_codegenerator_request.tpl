            $htmlFilter = new HtmlFilter();
          //$htmlFilter->addFilter( new UrlConverter() );
          //$htmlFilter->addFilter( new RegexpFilter() );

{foreach from=$status item=obj}
{section name=i loop=$vName3}
{if $obj->name == $vName5[i]}
            {if $obj->type ==              'varchar'}${$vName2[i]|even:20} =       $this->_request->getFilteredValue('{$oName2}{$vName3[i]}', $htmlFilter );
{elseif $obj->type ==                             'text'}${$vName2[i]|even:20} =       $this->_request->getFilteredValue('{$oName2}{$vName3[i]}', $htmlFilter );
{elseif $obj->type ==                              'int'}${$vName2[i]|even:20} = (int) $this->_request->getValue('{$oName2}{$vName3[i]}');
{elseif $obj->type ==   'tinyint' && $obj->max_length==1}${$vName2[i]|even:20} =       Textfilter::checkboxToBoolean( $this->_request->getValue('{$oName2}{$vName3[i]}') );
{elseif $obj->type ==                          'tinyint'}${$vName2[i]|even:20} = (int) $this->_request->getValue('{$oName2}{$vName3[i]}');
{else}${$vName2[i]|even:20} =       $this->_request->getValue('{$oName2}{$vName3[i]}'); // {$vName2[i]} type is {$obj->type}
{/if}
{/if}
{/section}
{/foreach}