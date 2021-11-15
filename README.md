# Auth

Микросервис Auth для курса Ruby Microservices.

# Зависимости

- Ruby `2.7.3`
- Bundler `2.2.28`
- Sinatra `6.0+`
- Puma `4.3+`
- PostgreSQL `9.3+`

# Установка и запуск приложения

1. Склонируйте репозиторий:

```
git clone git@github.com:dmi3-bu/auth.git && cd Auth
```

2. Установите зависимости и создайте базу данных:

```
bundle install
rake db:create db:migrate
RACK_ENV=test rake db:create db:migrate
```

3. Запустите приложение:

```
bundle exec rackup -p 9293
```

# Запуск тестов

```
bundle exec rspec
```

# Запуск сидов

```
bundle exec rake db:seed
```

# Деплой
```
docker build -t auth .
ansible-playbook deploy/deploy.yml
```