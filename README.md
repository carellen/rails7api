# Rails 7 api template with JWT auth

## Getting Started
### Prerequisites:

* Git
* Docker
* Docker Compose

### Installing

* clone the project

    `git clone https://github.com/carellen/rails7api.git`

* go to project folder

    `cd rails7api`
    
* create `.env` file and fill with some ENV variables(see `.env.sample`)

    `touch .env`
    
### First run

`docker-compose build`

`docker-compose up -d`

`docker-compose run --rm app bundle exec rails db:create db:migrate`

`docker logs -f rails7api_app_1`

### Local Usage

Online docs: `http://lvh.me/apidocs`

Users list: `api.lvh.me/users`

### Stop application

`docker-compose down`

### Gotchas

Do not forget to add `Authorization` header after login!

`Authorization: Bearer longstringfromloginresponse`

### Testing

`rails test`
