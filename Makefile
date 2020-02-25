.PHONY: help
help: ## this description
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
setenv: .env.example ## setup .env file
	@cp .env.example .env
up: docker-compose.yml ## exec 'docker-compose up -d'
	@make setenv
	@docker-compose up -d
build: docker-compose.yml ## build container
	@make setenv
	@docker-compose build
.PHONY: stop
stop: docker-compose.yml ## stop container
	@docker-compose stop
.PHONY: restart
restart: docker-compose.yml ## restart container
	@make setenv
	@docker-compose restart
.PHONY: down
down: docker-compose.yml ## down container
	@docker-compose down
.PHONY: destroy
destroy: docker-compose.yml ## cleanup image and container
	@docker-compose down --rmi all --volumes
.PHONY: ps
ps: ## ps command
	@docker-compose ps
.PHONY: app
app: ## exec command
	@docker-compose exec app ash -l
.PHONY: local
local: ## execute local server
	@/usr/bin/env php -S localhost:8080
