# Domicile Webapp
## getting started
```sh
git clone https://github.com/tobiasbhn/domicile.git
cd domicile/domicile-web
```


### prerequisites
For building and running this Repository with docker you need to install docker and docker-compose.
You will find detailed information on how to install the docker dependencies here:
* [Docker](https://docs.docker.com/install/)
* [Docker-Compose](https://docs.docker.com/compose/install/)

Currently used Versions:
* Docker version 19.03.5, build 633a0ea838
* docker-compose version 1.24.1, build 4667896b



### for production: generate necessary config
Provide master key:
```sh
printf "put_master_key_here" >> config/master.key
```
You also need to provide some environemnt variables. To copy a blueprint:
```sh
cp .env.example .env
```



### docker & docker-compose
Build Image in Development:
```sh
DOCKER_BUILDKIT=1 docker build . -t domicile_web:dev --target development
```
Build Image in Production:
```sh
DOCKER_BUILDKIT=1 docker build . -t domicile_web:prod --target production --build-arg RAILS_MASTER_KEY=$(cat config/master.key)
```

Start Container in Development:
```sh
docker-compose up -d -V
```
Start container in Production:
```sh
docker-compose -f docker-compose.yml -f docker-compose.production.yml up -d -V
```

Stop container:
```sh
docker-compose down
```

Bash into Container
```sh
docker ps
docker exec -it <CONTAINER ID> /bin/sh
```

## testing
Run Tests:
```sh
docker-compose run web rails test
docker-compose run web rails test test/system
```

## keeping the docker setup up to date
### changed docker files

If the docker instances changed you need to rebuild and restart everyting.
```bash
docker-compose down
DOCKER_BUILDKIT=1 docker build . -t domicile_web:dev --target development
docker-compose up -d -V
```



### cleanup docker environment
Docker generally never deletes something what may be useful again. Which means,
that it never deletes anything.

To clean up the mess you should execute
```sh
docker system prune
```
from while to while.

To reset hard, execute (be carefull! this will delete images and volumes aswell!)
```sh
docker system prune --all --volumes -f
```
