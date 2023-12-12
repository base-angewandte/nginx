# Deployment

- Create system user
- Install docker and docker-compose
- Change user:

  ```bash
  sudo su - base
  ```

- Clone git repository:

  ```bash
  git clone https://github.com/base-angewandte/nginx.git
  cd nginx
  ```

- Create `.env` and adapt the settings:

  ```bash
  cp env-skel .env
  vi .env
  ```

- Create and adapt `docker-compose.override.yml`:

  ```bash
  cp docker-compose.override.skel.yml docker-compose.override.yml
  vi docker-compose.override.yml
  ```

  If you want to activate all configurations you need to minimally set the following:

  ```yaml
  environment:
    # activate the following (empty) environment variables to activate those services
    - BASEAUTH=
    - PORTFOLIO=
  ```

  These settings are set to `#` by default (see the _docker-compose.yml_ file) and
  will comment out the respective nginx configurations. By setting it to an empty string,
  the relevant nginx config sections will be enabled.

  Additionally, you can use the `INDEX_REDIRECT` environment variable to redirect directly
  to one of your apps (in this case probably portfolio is the only viable one). If you leave
  this setting commented the default `/` will make sure that there is no redirect. This way
  users will receive a 404 from nginx (unless you provide an _index.html_ file mounted with an
  extra volume to _/etc/nginx/html/index.html_). So, in order to redirect e.g. to portfolio,
  use the following:

  ```yaml
    # if the root URI "/" should redirect to an app (e.g. portfolio), uncomment this and set it to /portfolio
    - INDEX_REDIRECT=/portfolio
  ```

- Initialize Let's Encrypt:

  ```bash
  make init
  ```

  If you don't want to use Let's Encrypt, but your own certificates, skip this step and do the following:

  - Disable certbot by adding the following to the override file:

  ```yaml
  certbot:
    deploy:
      replicas: 0
  ```

  - Mount your certificate and key in the override file:

  ```yaml
  volumes:
    - /path/to/own/certificate.pem:/etc/letsencrypt/live/${BASE_HOSTNAME}/fullchain.pem
    - /path/to/own/certificate/key.pem:/etc/letsencrypt/live/${BASE_HOSTNAME}/privkey.pem
  ```

- Start the project with `make start`

- Use Makefile with `sudo`:

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

  # reload
  make reload

  # rotate logfile
  make logrotate

  # update
  make update

  # initialize Let's Encrypt
  make init
  ```
