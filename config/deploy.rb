# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"

set :application, "rails_lesson"
set :repo_url, "git@github.com:kotakanazawa/rails_lesson.git"
set :user, 'deploy'
set :deploy_to, "/srv/rails_lesson"
set :pty, true
append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :deploy_via, :remote_cache
set :conditionally_migrate, true

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

# bundlerの設定
append :linked_dirs, '.bundle'
set :bundle_jobs, 2
