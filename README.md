This is not meant for public! I'm a Laravel Beginner and these are kind-of my notes to record how I got a boilerplate running with all features I want to get it reproducable later on.


## Installation

```bash
docker run --rm -v $PWD:/app:Z composer create-project laravel/laravel laravel
sudo chmod 777 -R laravel
cp .env.example laravel/.env
sudo setenforce 0
```

# Start

```bash
docker-compose up --build -d
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
php artisan adminlte:install --only=main_views
```

Copy basic page from examples to `resources/views`
```
cp ../examples/home.blade.php resources/views/home.blade.php
```

# Laravel Mix

https://laravel-mix.com/docs/6.0/installation#laravel-projects

```
npm install

# separate terminal (or screen):
npm run watch
```

# Livewire

while installing, listen to: https://open.spotify.com/track/6FWoYwZa13llS7nj0SG65F  
this is mandatory! otherwise it won't work! trust me.

https://laravel-livewire.com/docs/2.x/quickstart

```
composer require livewire/livewire
php artisan vendor:publish --tag=livewire:config
```



# Routes

example route
```
Route::get('/example', function () {
    return view('example');
});
```
