FROM ruby:2.6.5

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

# cronのインストール
# RUN apt-get install -y cron

WORKDIR /myproject

COPY Gemfile /myproject/Gemfile
COPY Gemfile.lock /myproject/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /myproject

# cronの実行
# RUN bundle exec whenever --update-crontab 
# CMD ["cron", "-f"] 

#本番環境で行う動作
# COPY start.sh /start.sh
# RUN chmod 744 /start.sh
# CMD ["sh","/start.sh"]
