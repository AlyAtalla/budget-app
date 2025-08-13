# Puma configuration file

# Threads configuration
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Environment
environment ENV.fetch("RAILS_ENV") { "development" }

# Port & bind
port ENV.fetch("PORT") { 3000 }          # Default to 3000 if PORT not set
bind "tcp://0.0.0.0:#{ENV.fetch('PORT') { 3000 }}"  # Ensure container can access

# Workers for clustered mode
worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })
workers worker_count if worker_count > 1

# Worker timeout for development
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Preload application for faster worker boot
preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# Optional SSL binding (uncomment if using SSL)
# ssl_bind '0.0.0.0', '3001', {
#   key: ENV.fetch("SSL_KEY_PATH") { "path/to/server.key" },
#   cert: ENV.fetch("SSL_CERT_PATH") { "path/to/server.crt" },
#   verify_mode: "none"
# }
