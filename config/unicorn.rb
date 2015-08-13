# variables
deploy_to   = "/home/deployer/deployed_apps/documents"
rails_root  = "#{deploy_to}/current"
pid_file    = "#{deploy_to}/shared/pids/unicorn.pid"
socket_file = "#{deploy_to}/shared/unicorn.sock"
log_file    = "#{rails_root}/log/unicorn.log"
err_log     = "#{rails_root}/log/unicorn.error.log"
old_pid     = pid_file + '.oldbin'

worker_processes 8

working_directory rails_root

listen socket_file, backlog: 1024

timeout 30 # nuke workers after 30 seconds instead of 60 seconds (the default)
pid pid_file
stderr_path log_file
stdout_path log_file

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
  
# Enable this flag to have unicorn test client connections by writing the
# beginning of the HTTP headers before calling the application.  This
# prevents calling the application for connections that have disconnected
# while queued.  This is only guaranteed to detect clients on the same
# host unicorn runs on, and unlikely to detect disconnects even on a
# fast LAN.
check_client_connection false


before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  
  # The following is only recommended for memory/DB-constrained
  # installations.  It is not needed if your system can house
  # twice as many worker_processes as you have configured.
  #
  # # This allows a new master process to incrementally
  # # phase out the old master process with SIGTTOU to avoid a
  # # thundering herd (especially in the "preload_app false" case)
  # # when doing a transparent upgrade.  The last worker spawned
  # # will then kill off the old master process with a SIGQUIT.
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.reload(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
  #
  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.
  # sleep 1
end

after_fork do |server, worker|
  # После того как рабочий процесс создан, он устанавливает соединение с базой.
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end
