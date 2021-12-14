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

## Start

```bash
docker-compose up --build -d
```
see http://localhost:8000

if laravel container is constantly restarting, stating `Could not open input file: artisan` then you're using a system where SELinux Z-labeling does not work with Docker. You can temporarily set SELinux to permissive:
```
sudo setenforce 0
```

#### Bash functions (just execute as if they were installed natively)

Commands are first-letter-uppercase by intention so it does not overlap with native installations

```bash
function Composer() {
  docker run --rm -it -v $PWD:/app:Z composer ${@}
}
function Php() {
  case $1 in
    bash) 
      docker run -it --rm --network laravel -v $PWD:/www:Z -w /www --user $(id -u) php:local bash
    ;;
    *)
      CMD="php ${@}"
      docker run -it --rm --network laravel -v $PWD:/www:Z -w /www --user $(id -u) php:local bash -c "${CMD}"
    ;;
  esac
}
```

if you really want to override the native ones:
```
alias composer=Composer
alias php=Php
```


### Generate `APP_KEY` (will be automatically injected into `.env`)

```bash
cd laravel
Php artisan key:generate
```

## Notes

To use a https reverse proxy, you need to force https.
Add to `app/Providers/AppServiceProvider.php`:
```bash
    public function boot()
    {
        \Illuminate\Support\Facades\URL::forceScheme('https');
    }
```
