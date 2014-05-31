# Ensure that bundle is used for rake tasks
# SSHKit.config.command_map[:rake] = "bundle exec rake"

# set :default_environment, {
#   'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
# }

# config valid only for Capistrano 3.1
lock '3.2.1'

# Set rbenv specific settings
set :rbenv_type, :user
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :application, 'netrunner'
set :repo_url, 'git@github.com:ryakh/netrunner.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, 'master'

set :deploy_via, :copy
set :stages, ['production']

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/netrunner'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/application.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      run "if ! [[ -d #{current_path}/tmp]]; mkdir #{current_path}/tmp; fi"
      execute :touch, release_path.join("#{current_path}/tmp/restart.txt")
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
