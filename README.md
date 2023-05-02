# README

### start the app
$ docker compose run --rm app rails db:reset db:migrate db:seed
$ docker compose up

### rails console
$ docker compose run --rm app rails c
