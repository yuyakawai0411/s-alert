FROM ruby:2.6.5

ENV RAILS_ENV="development"

#nodejsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

# yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y yarn

# cronのインストール
# RUN apt-get install -y cron

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /app

HEALTHCHECK --interval=30s --timeout=5s --start-period=240s --retries=5 CMD curl -f http://localhost:3000/ || exit 1

# cronの実行
# RUN bundle exec whenever --update-crontab 
# CMD ["cron", "-f"] 

#本番環境で行う動作
COPY start.sh /start.sh
RUN chmod 744 /start.sh
VOLUME /app/tmp/sockets
CMD ["sh","/start.sh"]
