This is not meant for public! I'm a Laravel Beginner and there are kind-of my notes to record how I got a boilerplate running with all features I want.


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


#### Bash functions (just execute as if they were installed natively)

```
source .bashrc
```

### Generate `APP_KEY` (will be automatically injected into `.env`)

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
Composer require jeroennoten/laravel-adminlte
Php artisan adminlte:install
Composer require laravel/ui
Php artisan ui bootstrap --auth
Php artisan adminlte:install --only=auth_views
```
