# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"

set :application, "rails_lesson"
set :repo_url, "git@github.com:kotakanazawa/rails_lesson.git"
set :user, "deploy"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/srv/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :deploy_via, :remote_cache
set :conditionally_migrate, true

# rbenvの設定
set :rbenv_type, :user
set :rbenv_custom_path, '/home/deploy/.anyenv/envs/rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all

# bundlerの設定
append :linked_dirs, ".bundle"
set :bundle_jobs, 1

# nodeの設定
set :default_env, { NODE_ENV: 'production' }

desc "Initial Deploy"
task :initial do
  on roles(:app) do
    before 'deploy:restart', 'puma:start'
    invoke 'deploy'
  end
end

desc "Restart Application"
task :restart do
  on roles(:app), in: :sequence, wait: 5 do
    invoke 'puma:restart'
  end
end

# pumaコマンドをbundle execで実行
append :rbenv_map_bins, "puma", "pumactl"
