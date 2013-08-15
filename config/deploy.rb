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
    restart_ticker
    restart_jabber_bots
    restart_notification_ticker
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

  desc "Start Thin and Tickers"
  task :start_all do
    start
    start_ticker
    start_notification_ticker
  end

  desc "Stop Thin and Tickers"
  task :stop_all do
    stop
    stop_ticker
    stop_notification_ticker
  end

  desc "Restart Ticker"
  task :restart_ticker do
    stop_ticker
    start_ticker
  end

  desc "Start Ticker"
  task :start_ticker do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/ticker start"
  end

  desc "Stop Ticker"
  task :stop_ticker do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/ticker stop"
  end
  
  desc "Restart Notification Ticker"
  task :restart_notification_ticker do
    stop_notification_ticker
    start_notification_ticker
  end

  desc "Start Notification Ticker"
  task :start_notification_ticker do
    if stage != 'staging_test'
      run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/notification_ticker start"
    end
  end

  desc "Stop Notification Ticker"
  task :stop_notification_ticker do
    if stage != 'staging_test'
      run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/notification_ticker stop"
    end
  end
  
  desc "Check Consistency"
  task :check_consistency do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/repair_consistency"
  end

  desc "Start Jabber Bots"
  task :start_jabber_bots do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/jabber_bots start"
  end

  desc "Stop Jabber Bots"
  task :stop_jabber_bots do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/jabber_bots stop"
  end

  desc "Restart Jabber Bots"
  task :restart_jabber_bots do
    stop_jabber_bots
    start_jabber_bots
  end
end
