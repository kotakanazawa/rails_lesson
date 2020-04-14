server "kota-kanazawa.work", user: "deploy", roles: %w{web db app}

# ssh
set :ssh_options, {
  user: "deploy", # TODO change to fetch(:user)
  port: 10022, # TODO move to the line in the server
  keys: ["#{ENV.fetch('PRODUCTION_SSH_KEY')}"],
  forward_agent: true,
  auth_methods: %w[publickey]
}

# nginx
set :nginx_config_name, "#{fetch(:application)}"
set :nginx_server_name, "kota-kanazawa.work"
set :nginx_use_ssl, true
set :nginx_ssl_certificate, "/etc/letsencrypt/live/kota-kanazawa.work/fullchain.pem"
set :nginx_ssl_certificate_key, "/etc/letsencrypt/live/kota-kanazawa.work/privkey.pem"

