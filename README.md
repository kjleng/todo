# README

### start the app
$ docker compose up
$ docker compose run --rm app rails db:reset db:migrate db:seed

### rails console
$ docker compose run --rm app rails c

### enhancement with multistage build
original docker image is 735MB
multistage build docker image is 578MB
