# 環境構築関連（初めからProjectを作る場合）
create-project:
	@make up
	docker compose exec app composer create-project laravel/laravel . --prefer-dist "9.*"
	docker compose exec app chmod -R 777 storage bootstrap/cache
	docker compose exec app composer require laravel/breeze --dev
	docker compose exec app php artisan breeze:install vue
	docker compose exec node npm install
	@make run
# git cloneしてローカルで環境構築する場合（.envのDB設定は事前にしておくこと）
init:
	@make up
	@make composer-install
	docker compose exec app chmod -R 777 storage bootstrap/cache
	@make migrate-seed
	@make ci-run
restart:
	@make down
	@make up
up:
	docker compose up --build -d
down:
	docker compose down --remove-orphans
destroy:
	docker compose down --remove-orphans --volumes
build:
	docker compose build

# Laravel Projectの作成
project-start:
	docker compose exec app composer create-project laravel/laravel sample --prefer-dist "9.*"

# キュー関連
queue:
	docker compose exec app php artisan queue:work
queue-restart:
	docker compose exec app php artisan queue:restart

# JS関連
watch:
	docker compose exec node npm run watch
ci-run:
	@make ci
	@make run
ci: 
	docker compose exec node npm ci
run:
	docker compose exec node npm run dev
prod:
	docker compose exec node npm run prod

# DB関連
migrate-seed:
	docker compose exec app php artisan migrate --seed
migrate:
	docker compose exec app php artisan migrate
fresh:
	docker compose exec app php artisan migrate:fresh --seed
seed:
	docker compose exec app php artisan db:seed

# テスト関連
test:
	docker compose exec app php artisan test
each-test:
	docker compose exec app php artisan test ${TARGET}

# composer関連
composer-install:
	docker compose exec app composer install
composer-update:
	docker compose exec app composer update

# 各コンテナ内に入る
web:
	docker compose exec web ash
app:
	docker compose exec app bash
node:
	docker compose exec node bash
db:
	docker compose exec db bash

# コンテナの状態を確認する
ps:
	docker compose ps