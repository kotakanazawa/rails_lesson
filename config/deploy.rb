# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"

set :application, "rails_lesson"
set :repo_url, "git@github.com:kotakanazawa/rails_lesson.git"
set :user, "deploy"
set :deploy_to, "/srv/#{fetch(:application)}"
set :branch, "master"

# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# namespace :safe_deploy_to do
#   task :push_config do
#     next unless any? :linked_files
#     on roles(:app) do
#       fetch(:linked_files).each do |file|
#         unless test "[ -f #{shared_path.join file} ]"
#           execute :mkdir, '-p', shared_path.join(File.dirname(file))
#           upload! file, "#{shared_path.join file}"
#         end
#       end
#     end
#   end
#   after 'safe_deploy_to:ensure', 'safe_deploy_to:push_config'
# end

set :keep_releases, 5
set :log_level, :debug

# # rbenvの設定
set :rbenv_type, :user
# set :rbenv_custom_path, '/home/deploy/.anyenv/envs/rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all

# bundlerの設定
append :linked_dirs, ".bundle"
set :bundle_jobs, 1

# # nodeの設定
set :default_env, { NODE_ENV: 'production' }

# desc "Initial Deploy"
# task :initial do
#   on roles(:app) do
#     before 'deploy:restart', 'puma:start'
#     invoke 'deploy'
#   end
# end

# desc "Restart Application"
# task :restart do
#   on roles(:app), in: :sequence, wait: 5 do
#     invoke 'puma:restart'
#   end
# end

# pumaコマンドをbundle execで実行
append :rbenv_map_bins, "puma", "pumactl"
