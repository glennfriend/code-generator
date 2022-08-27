{literal}
## add composer.json
```
{
    "name": "ydin/oooo-xxxx",
    "require": {
        "laravel/framework": ">=7.0",
        "php": "^7.4 || ^8.0 || ^8.1"
    },
    "autoload": {
        "psr-4": {
            "OoooXxxx\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "OoooXxxx\\Tests\\": "tests/"
        }
    },
    "extra": {
        "laravel": {
            "providers": [
                "OoooXxxx\\OoooXxxxServiceProvider"
            ]
        },
        "branch-alias": {
            "dev-master": "1.0-dev"
        }
    },
    "config": {
        "sort-packages": true,
        "preferred-install": "dist"
    },
    "license": "MIT",
    "prefer-stable": true,
    "minimum-stability": "dev"
}
```








## Oooo Xxxx Package

### feature
- (ydin 為 完全獨立, cor 為 個人深度整合)
- 自帶有簡易的 route and view page ????

### dependancy
- mysql (請自行安裝)
- composer laravel/framework
- Illuminate\Support\Facades\Log


### example


### install composer package
```
pname="oooo-xxxx"
docker exec xxxxxx  composer remove "ydin/${pname}"
docker exec xxxxxx  composer config "repositories.${pname}" path "packages/ydin-${pname}"
docker exec xxxxxx  php -d memory_limit=-1  /usr/local/bin/composer require "ydin/${pname}:dev-master"

php artisan migrate
```

### 還缺少的功能
- ________








## For developer
- README_FOR_DEVELOPER.md

### vi .gitignore
```
/packages/__*
```

### clone your package
```
git clone xxxxxxxxxx "packages/__ydin-oooo-xxxx"
```

### local development
```
pname="oooo-xxxx"
docker exec xxxxxx  composer remove "ydin/${pname}"
docker exec xxxxxx  composer config "repositories.${pname}" path "packages/__ydin-${pname}"
docker exec xxxxxx  php -d memory_limit=-1  /usr/local/bin/composer require "ydin/${pname}:dev-master" --update-with-dependencies
```

### git tag push
```
git tag 0.1.0
git push origin --tags

or

git tag 0.x.x  --force
git push origin --tags  --force
```

### update packagist.org
```
update to https://packagist.org/packages/ydin/oooo-xxxx (or hook)
```

### remove local to install composer package
```
pname="oooo-xxxx";
docker exec xxxxxx  composer remove "ydin/${pname}"
docker exec xxxxxx  composer config "repositories.${pname}" path ""
docker exec xxxxxx  php -d memory_limit=-1  /usr/local/bin/composer require "ydin/${pname}:0.1.0"
```

### about APIDOC
```
npm install apidoc apidoc-plugin-json -g
apidoc -i ./src/ -o ./public/apidoc

php -S 127.0.0.1:8008 -t public/apidoc/
google-chrome http://127.0.0.1:8008
```

### test
```
vendor/bin/phpunit --testdox --colors=always -v packages/ydin-oooo-xxxx/tests
or
../../vendor/bin/phpunit --testdox --colors=always -v tests
```
{/literal}