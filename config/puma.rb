# Puma configuration file

# Threads
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Workers
if ENV.fetch("RAILS_ENV") == "production"
  require "concurrent-ruby"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1

  # Preload app for faster worker boot
  preload_app!
else
  # In development, default to 1 worker
  workers ENV.fetch("WEB_CONCURRENCY") { 1 }
  # Worker timeout only for dev to avoid auto-kill during debugging
  worker_timeout 3600
end

# Port and environment
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }

# PID file
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `rails restart` command
plugin :tmp_restart
