# Puma configuration file

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

environment ENV.fetch("RAILS_ENV") { "development" }
port ENV.fetch("PORT") { 3000 }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Workers for clustered mode
worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })
workers worker_count if worker_count > 1

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

preload_app!

# Optional SSL binding (uncomment if you have certs)
# ssl_bind '0.0.0.0', '3001', {
#   key: ENV.fetch("SSL_KEY_PATH") { "path/to/server.key" },
#   cert: ENV.fetch("SSL_CERT_PATH") { "path/to/server.crt" },
#   verify_mode: "none"
# }

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
