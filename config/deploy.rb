# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'latex_server_production'
set :repo_url, 'git@github.com:luizamboni/latex_server.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/formula')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

before "deploy:updated", "deploy:set_permissions"

# capistrano-passenger
set :passenger_restart_with_touch, true

namespace :deploy do

  desc 'set permissions'
  task :set_permissions do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{fetch(:deploy_to)}; chown -R -f www-data:www-data *"
      execute "mkdir -p #{release_path.join('tmp')}"
      execute :touch, release_path.join('tmp/restart.txt')
      execute "cd #{fetch(:deploy_to)}; chown -R -f www-data:www-data *"
    end
  end

end