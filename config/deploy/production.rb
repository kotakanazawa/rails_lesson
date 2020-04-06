server "kota-kanazawa.work", user: "deploy", roles: %w{web db app}

# ssh
set :ssh_options, {
  user: "deploy",
  port: 10022,
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w[publickey]
}

# nginx
set :nginx_config_name, "#{fetch(:application)}"
set :nginx_server_name, "localhost #{fetch(:nginx_config_name)}"
set :nginx_use_ssl, true
set :nginx_ssl_certificate, "/etc/letsencrypt/live/#{fetch(:nginx_config_name)}/fullchain.pem"
set :nginx_ssl_certificate_key, "/etc/letsencrypt/live/#{fetch(:nginx_config_name)}/privkey.pem"
