# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"

set :application, "rails_lesson"
set :repo_url, "git@github.com:kotakanazawa/rails_lesson.git"
set :user, 'deploy'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/srv/rails_lesson"

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

# bundlerの設定
append :linked_dirs, '.bundle'
set :bundle_jobs, 1

# pumaコマンドをbundle execで実行
append :rbenv_map_bins, 'puma', 'pumactl'
