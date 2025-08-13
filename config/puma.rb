# Puma configuration file

# Threads configuration
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Environment
environment ENV.fetch("RAILS_ENV") { "development" }

# Port (Railway injects the PORT env variable)
port ENV.fetch("PORT") { 3000 }

# PID file
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Workers for clustered mode (only in production)
worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })
workers worker_count if worker_count > 1

# Worker timeout in development
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Preload app for faster worker boot
preload_app!

# Optional SSL binding (uncomment if you have certs)
# ssl_bind '0.0.0.0', ENV.fetch("SSL_PORT") { 3001 }, {
#   key: ENV.fetch("SSL_KEY_PATH") { "path/to/server.key" },
#   cert: ENV.fetch("SSL_CERT_PATH") { "path/to/server.crt" },
#   verify_mode: "none"
# }

# Allow puma to be restarted by `rails restart` command
plugin :tmp_restart
