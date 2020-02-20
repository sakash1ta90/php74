up: .env.example
	@cp .env.example .env
	@docker-compose up -d
build: docker-compose.yml
	@docker-compose build
stop: docker-compose.yml
	@docker-compose stop
restart: docker-compose.yml
	@docker-compose restart
down: docker-compose.yml
	@docker-compose down
destroy: docker-compose.yml
	@docker-compose down --rmi all --volumes
ps:
	@docker-compose ps
app:
	@docker-compose exec app ash -l
local:
	@/usr/bin/env php -S localhost:8080
