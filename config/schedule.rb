# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
require File.expand_path(File.dirname(__FILE__) + "/environment.rb")
# ジョブのパス
#env :PATH, ENV['PATH']
#rails_env = ENV['RAILS_ENV'] || :development
# ログの出力先
set :output, 'log/cron.log'
# ジョブの実行環境
#set :environment, rails_env
set :environment, :development
job_type :runner ,"export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && bundle exec rails runner :task :output" 
#ログのメール通知
env 'MAILTO', 'yuya.scuba0411@gmail.com'
#ジョブ
every 1.minutes do
  runner "NoticeMailer.notice_mail"
end

# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#

#every 1.days, at: '8:00 am' do

# every 1.minutes do
#   runner "NoticeMailer.send_mail.deliver_now"
# end

# Learn more: http://github.com/javan/whenever
