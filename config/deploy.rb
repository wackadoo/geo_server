require "bundler/capistrano"

set :stages, %w(production staging)
set :default_stage, "staging"

require "capistrano/ext/multistage"

`ssh-add`

default_run_options[:pty] = true                  # problem with ubuntu
set :ssh_options, :forward_agent => true          # ssh forwarding
set :port, 5775

set :application, "game server"
set :repository,  "git@github.com:wackadoo/geo_server.git"
set :branch,      "staging"

set :scm, :git

set :user, "deploy-ge"
set :use_sudo, false

set :deploy_to, "/var/www/geo_server"
set :deploy_via, :remote_cache

desc "Print server name"
task :uname do
  run "uname -a"
end

namespace :deploy do
  desc "Restart Thin"
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end

  desc "Reset DB"
  task :reset do
    #
    # security advice: don't forget to comment out after use, don't commit it uncommented!!!
    #
    #run "cd #{current_path}; bundle exec rake RAILS_ENV=\"#{stage}\" db:reset"
    #restart
    #exit
  end

  desc "Start Thin"
  task :start do
    run "cd #{current_path}; bundle exec thin -C config/thin_#{stage}.yml start"
  end

  desc "Stop Thin"
  task :stop do
    run "cd #{current_path}; bundle exec thin -C config/thin_#{stage}.yml stop"
  end

end
