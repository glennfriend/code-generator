// ------------------------------------------------------------
//  request
// ------------------------------------------------------------
// {$mod->lower('_')}_store.json
// {$mod->lower('_')}_update.json
{
  "data": {
{foreach $tab as $key => $field}
{if $key==='id'}
    "{$field.ado->name}":{$field.ado->name|space_even} 1,
{elseif $key==='attribs'}
    "{$field.ado->name}":{$field.ado->name|space_even} null,
{elseif $field.ado->type=='tinyint'}
    "{$field.ado->name}":{$field.ado->name|space_even} 2,
{elseif $field.ado->type=='smallint' || $field.ado->type=='mediumint' || $field.ado->type=='int' || $field.ado->type=='bigint'}
    "{$field.ado->name}":{$field.ado->name|space_even} 10,
{elseif $field.ado->type=='timestamp' || $field.ado->type=='datetime' || $field.ado->type=='date'}
    "{$field.ado->name}":{$field.ado->name|space_even} "2000-01-01T00:00:00.000000Z",
{elseif $field.ado->type=='json'}
    "{$field.ado->name}":{$field.ado->name|space_even} null,  // "json"
{elseif $field.ado->type=='text' || $field.ado->type=='mediumtext' || $field.ado->type=='longtext'}
    "{$field.ado->name}":{$field.ado->name|space_even} null,  // '"ext"
{else}
    "{$field.ado->name}":{$field.ado->name|space_even} "unknown",
{/if}
{/foreach}
  },
  "meta:": {}
}

// ------------------------------------------------------------
// response
// ------------------------------------------------------------
// {$mod->lower('_')}_list_response.json
{
  "data": {},
  "links": {},
  "meta": {}
}
// {$mod->lower('_')}_show_response.json
{
  "data": {
    "oooo": "oooo",
    "oooo": "oooo",
    "account": {}
    "blogArticleComment(s?)": {}
  }
}
