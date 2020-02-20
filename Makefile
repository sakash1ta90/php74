up:
	cp .env.example .env
	docker-compose up -d
build:
	docker-compose build
reinstall:
	@make destroy
	@make install
stop:
	docker-compose stop
restart:
	docker-compose restart
down:
	docker-compose down
destroy:
	docker-compose down --rmi all --volumes
ps:
	docker-compose ps
app:
	docker-compose exec app ash -l
local:
	/usr/bin/env php -S localhost:8080
