## Installation

composer create-project
```bash
docker run --rm -v $PWD:/app composer create-project laravel/laravel laravel
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
docker-compose up -d
```

see http://localhost:8000


regenerate the `APP_KEY` (will be automatically injected into `.env`)

```bash
docker run --rm -v $PWD/laravel:/www -w /www php:8 php artisan key:generate
```

bash functions (always execute in laravel folder as if composer was installed natively)
Commands are first-letter-uppercase by intention so it does not overlap with native installations

```bash
function Composer() {
  docker run --rm -it -v $PWD:/app composer ${@}
}
function Php() {
  case $1 in
    bash) 
      docker run -it --rm -v $PWD:/www -w /www --user $(id -u) php:8 bash
    ;;
    *)
      CMD="php ${@}"
      docker run -it --rm -v $PWD:/www -w /www --user $(id -u) php:8 bash -c "${CMD}"
    ;;
  esac
}
```

To use a https reverse proxy, you need to force https.
Add to `app/Providers/AppServiceProvider.php`:
```bash
    public function boot()
    {
        \Illuminate\Support\Facades\URL::forceScheme('https');
    }
```
