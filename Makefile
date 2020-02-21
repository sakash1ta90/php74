.PHONY: help
help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
setenv: .env.example
	@cp .env.example .env
up: docker-compose.yml
	@make setenv
	@docker-compose up -d
build: docker-compose.yml
	@make setenv
	@docker-compose build
.PHONY: stop
stop: docker-compose.yml
	@docker-compose stop
.PHONY: restart
restart: docker-compose.yml
	@make setenv
	@docker-compose restart
.PHONY: down
down: docker-compose.yml
	@docker-compose down
.PHONY: destroy
destroy: docker-compose.yml
	@docker-compose down --rmi all --volumes
.PHONY: ps
ps:
	@docker-compose ps
.PHONY: app
app:
	@docker-compose exec app ash -l
.PHONY: local
local:
	@/usr/bin/env php -S localhost:8080
