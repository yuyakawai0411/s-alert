#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]
then
    bundle exec rails assets:precompile RAILS_ENV=production
fi

DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed

RAILS_SERVE_STATIC_FILES=1 bundle exec unicorn_rails -c /app/config/unicorn.rb -E production -p 3000