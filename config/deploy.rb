set :user, "decorosa"
set :domain, "www.rafaelrosafu.com"
set :application, "rafaelrosafu"

default_run_options[:pty] = true
set :scm_user, "rafaelrosafu"
set :scm_password, Proc.new { Capistrano::CLI.password_prompt "SCM Password: "}
set :repository,  "git@github.com:rafaelrosafu/bolongu-bongo.git" 
set :scm, :git
set :deploy_via, :remote_cache
set :remote, scm_user
set :scm_verbose, true
set :branch, 'master'
set :git_repo, "/home/decorosa/repo/rafaelrosafu.git"
set :git_enable_submodules, 1
set :git_shallow_clone, 1

role :web, domain
role :app, domain
role :db, domain
 
set :deploy_to, "/home/decorosa/rails_app/bolungo"
set :public_html, "/home/decorosa/public_html"
set :site_path, "/home/decorosa/public_html/bolungo"
set :runner, nil
set :use_sudo, false
set :no_release, true
 
set :copy_exclude, %w(.git/* .svn/* log/* tmp/* .gitignore)
set :keep_releases, 5

ssh_options[:forward_agent] = true
ssh_options[:username] = user
ssh_options[:paranoid] = false

namespace(:customs) do
  task :config, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml
    CMD
  end
  task :symlink, :roles => :app do
    run <<-CMD
      ln -s ~/rails_app/config/mail_config.rb #{release_path}/config/initializers/mail_config.rb
    CMD
  end
end

after "deploy:symlink","customs:symlink"
