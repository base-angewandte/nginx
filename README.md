# Deployment

* Create system user
* Install docker and docker-compose
* Change user:
	
	```bash
	sudo su - base
	```
		
* Clone git repository:

	```bash
	git clone https://github.com/base-angewandte/nginx.git
	cd nginx
	```

* Create `.env` and adapt the settings:

	```	bash
	cp env-skel .env
	vi .env
	```

* Check and adapt `nginx.conf`:

	```bash
	cp conf.d/nginx.template conf.d/nginx.conf
	vi conf.d/nginx.conf
	```

* Create and adapt `docker-compose.override.yml`:

	```bash
	cp docker-compose.override.skel.yml docker-compose.override.yml
	vi docker-compose.override.yml
	```

* Use Makefile with `sudo`:

	```bash
	# start
	make start
	
	# stop
	make stop
	
	# restart
	make restart
		
	# build
	make build
		
	# git pull
	make git-update

	# rotate logfile
	make logrotate

	# update
	make update
	```
