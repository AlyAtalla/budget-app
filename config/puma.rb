# Puma configuration file

# Threads configuration
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Environment
environment ENV.fetch("RAILS_ENV") { "production" }

# Port (Railway injects the PORT env variable)
port ENV.fetch("PORT") { 3000 }

# Bind to 0.0.0.0 (Railway requires this)
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

# PID file
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Workers for clustered mode (only in production)
worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })
workers worker_count if worker_count > 1

# Worker timeout (development only)
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "production") != "production"

# Preload app for faster worker boot
preload_app!

# Allow puma to be restarted by `rails restart` command
plugin :tmp_restart
