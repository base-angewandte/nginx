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
	docker-compose kill -s HUP nginx

logrotate:
	docker-compose exec nginx sh -c '/scripts/logrotate.sh'

update: git-update start

generate-selfsigned-cert:
	docker build -t openssl ./docker/openssl
	docker run -it -v `pwd`:/work openssl openssl req -newkey rsa:2048 -nodes -keyout /work/selfsigned.key -x509 -days 365 -out /work/selfsigned.crt
