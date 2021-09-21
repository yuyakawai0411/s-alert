#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]
then
    bundle exec rails assets:precompile 
fi

DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec unicorn_rails -c /app/config/unicorn.rb -E production -p 3000

