worker_processes 1

#ワークディレクトリを指定
$app_dir = "/app" 
working_directory $app_dir

#pidファイルでプロセス番号を管理
pid File.expand_path('tmp/pids/unicorn.pid', $app_dir)

#sockファイルでポート番号を指定
listen File.expand_path('tmp/sockets/unicorn.sock', $app_dir)

#ログの設定
stderr_path File.expand_path('log/unicorn.log', $app_dir)
stdout_path File.expand_path('log/unicorn.log', $app_dir)

timeout 60

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end