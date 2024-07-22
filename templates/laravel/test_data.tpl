// ------------------------------------------------------------
// value object
// ------------------------------------------------------------
class HelloResource extends \Spatie\LaravelData\Data implements JsonSerializable
{
  public function __construct(array $row)
    {
        parent::__construct($row);

        // required
        $this->accountId = $row['account_id'];

        // options
{foreach from=$tab key=key item=field}
        $this->{$field.name->lowerCamel()} = data_get($row, '{$field.name->lower('_')}');
{/foreach}
    }
}


// ------------------------------------------------------------
//  request
// ------------------------------------------------------------
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

// ------------------------------------------------------------
// class params
// ------------------------------------------------------------
class HelloUseCase extends UseCase
{
    #[ArrayType]
    #[ArrayType, Nullable]
    public array $config;

    #[BooleanType]
    public bool $isEnabled;

{foreach from=$tab key=key item=field}
{if $field.ado->type|in_array:['unsigned']}
    #[UnsignedInteger]
    public int ${$field.name->lower('_')};
{elseif $field.ado->type|in_array:['tinyint', 'int', 'smallint', 'bigint']}
    #[UnsignedInteger]
    public int ${$field.name->lower('_')};
{else}
    public string ${$field.name->lower('_')};
{/if}

{/foreach}
    public function handle(): array
    {
        return [];
    }
}

// ------------------------------------------------------------
// to array
// ------------------------------------------------------------
public function toArray(): array
{
    return [
{foreach from=$tab key=key item=field}
        '{$field.name->lower('_')}' {$field.name->lower('_')|space_even} => $this->{$field.name->lowerCamel()},
{/foreach}
    ];
}
