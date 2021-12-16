This is not meant for public! I'm a Laravel Beginner and these are kind-of my notes to record how I got a boilerplate running with all features I want to get it reproducable later on.


## Installation

composer create-project
```bash
docker run --rm -v $PWD:/app:Z composer create-project laravel/laravel laravel
```

Fix root permissions for local dev

```bash
sudo chmod 777 -R laravel
```

copy `.env.example` from this repo
```bash
cp .env.example laravel/.env
```

# Start

```bash
docker-compose up --build -d
```
if laravel container is constantly restarting, stating `Could not open input file: artisan` then you're using a system where SELinux Z-labeling does not work with Docker. You can temporarily set SELinux to permissive:
```
sudo setenforce 0
```

go to http://localhost:8000


#### Bash functions

these functions provide an almost feeling of `composer` and `node/npm` as if they were natively installed but use docker run commands.

```
source .bashrc
```

### Generate `APP_KEY`

will be automatically injected into `.env`

```bash
cd laravel
php artisan key:generate
```

### Execute Default Migrations

```
php artisan migrate

# check:
docker exec -t mysql mysql -e 'use laravel; show tables;'
```


### Notes

To use a https reverse proxy, you need to force https.
Add to `app/Providers/AppServiceProvider.php`:
```bash
    public function boot()
    {
        \Illuminate\Support\Facades\URL::forceScheme('https');
    }
```


#  AdminLTE Installation (notes from the original docs)

Full reference: https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Installation

```
composer require jeroennoten/laravel-adminlte
php artisan adminlte:install
composer require laravel/ui
php artisan ui bootstrap --auth
php artisan adminlte:install --only=auth_views
```
