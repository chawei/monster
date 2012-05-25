set :user,        "deployer"
set :domain,      "monster.detourlab.com"
set :application, "monster"

set :repository,  "git@github.com:chawei/monster.git"
set :scm,         :git
set :branch,      "master"
set :scm_verbose, true
set :deploy_via,  :remote_cache
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :use_sudo,    false
 
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :web, domain
role :app, domain 
role :db,  domain, :primary => true

# Passenger mod_rails:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Symlink config files and db"
  task :config_symlink do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/s3.yml #{release_path}/config/s3.yml"
  end
end

after "deploy:update_code", "deploy:config_symlink"