# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'instano-api'
set :repo_url, 'git@bitbucket.org:vedanta/instano-api.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :user, 'ubuntu'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :chruby_ruby, 'ruby-2.2.1'

# unicorn_nginx options
# ==================


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
set :ssh_options, {
  keys: %w(/home/vedant/.ssh/xmpp-user.pem),
  forward_agent: true
}

set :delayed_job_command, "bin/delayed_job"
set :rails_env, "production" #added for delayed job

before :deploy, 'deploy:check_revision'

namespace :deploy do

  after :finished, :restart_rpush do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, "rpush stop -e #{fetch(:rails_env)} ; true"
          execute :bundle, :exec, "rpush start -e #{fetch(:rails_env)}"
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc "build missing paperclip styles"
  task :build_missing_paperclip_styles do
    on roles(:app) do
      execute "cd #{current_path}; RAILS_ENV=production bundle exec rake paperclip:refresh:missing_styles"
    end
  end
end
