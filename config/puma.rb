# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 16 }
threads 1, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
#port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
#environment ENV.fetch("RAILS_ENV") { "development" }
environment ENV.fetch("RAILS_ENV") { "production" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# Use cluster mode and set the number of workers to 1.5x the number of cpu cores in the machine, minimum 2.
# grep -c processor /proc/cpuinfo --> 2
workers ENV.fetch("WEB_CONCURRENCY") { 3 }

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/tmp"

# Set up socket location
bind "unix://#{shared_dir}/puma.sock"

# Logging
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/puma.pid"
state_path "#{shared_dir}/puma.state"

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

#on_worker_boot do
#	ActiveSupport.on_load(:active_record) do
#		ActiveRecord::Base.establish_connection
#	end
	#require "active_record"
  #ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  #ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
#end

before_fork do
	# configuration here
end
