# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:

# set :output, "/path/to/my/cron_log.log"
require File.expand_path(File.dirname(__FILE__) + "/environment.rb")

# ジョブの実行環境
set :output, "#{Rails.root}/log/cron.log"
set :environment, :development
env 'MAILTO', 'yuya.scuba0411@gmail.com'
ENV.each { |k, v| env(k, v) }
job_type :runner ,"export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rails runner :task :output" 

every 5.minutes do
  runner "NoticeMailer.notice_mail"
end


# Learn more: http://github.com/javan/whenever
