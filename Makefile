.PHONY: help
help: ## ヘルプを表示する
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
setenv: .env.example ## .envファイルをexampleから生成する
	@cp .env.example .env
up: docker-compose.yml ## 'docker-compose up -d' を実行する
	@make setenv
	@docker-compose -f php.yml build
	@docker-slim b php_php74 --continue-after 1
	@docker-compose up -d
	@docker rmi php_php74
build: docker-compose.yml ## コンテナをビルドする
	@make setenv
	@docker-compose build
.PHONY: stop
stop: docker-compose.yml ## コンテナを停止する
	@docker-compose stop
.PHONY: restart
restart: docker-compose.yml ## コンテナを再起動する
	@make setenv
	@docker-compose restart
.PHONY: down
down: docker-compose.yml ## コンテナを停止する
	@docker-compose down
.PHONY: destroy
destroy: docker-compose.yml ## コンテナの停止とイメージの削除
	@docker-compose down --rmi all --volumes
.PHONY: ps
ps: ## psコマンドの実行
	@docker-compose ps
.PHONY: app
app: ## execコマンドの実行
	@docker-compose exec app ash -l
.PHONY: local
local: ## ローカルサーバの実行
	@/usr/bin/env php -S localhost:8080 -t src/public
