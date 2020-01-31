flask:
	@FLASK_APP=app/webapi.py flask run -h 0.0.0.0 -p 2080

ps:
	docker-compose ps

im:
	docker-compose images

build:
	docker-compose build --no-cache

up:
	docker-compose up -d

active:
	docker-compose up

down:
	docker-compose down

reup: down up

healthcheck:
	@sh healthcheck.sh

clean:
	docker-compose down --rmi all
	sudo rm -rf app/__pycache__
