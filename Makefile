include .env
export


start:
	docker-compose up -d --build

stop:
	docker-compose down

restart:
	docker-compose restart

build:
	docker-compose build

git-update:
	if [ "$(shell whoami)" != "base" ]; then sudo -u base git pull; else git pull; fi

reload:
	docker-compose exec nginx nginx -t
	docker-compose kill -s HUP nginx

logrotate:
	docker-compose exec nginx sh -c '/scripts/logrotate.sh'

update: git-update start

init:
	./init-letsencrypt.sh
