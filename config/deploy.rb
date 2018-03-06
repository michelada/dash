# config valid only for current version of Capistrano
lock '3.10.1'

set :application, 'michelada.io-blog'
set :repo_url, 'git@github.com:Michelada/dash.git'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :default_env, mix_env: 'prod', HOST: 'blog.michelada.io', PUBLIC_PORT: 80, SCHEME: 'http', PORT: 4002, ADMIN_PATH: 'yXAv41YW5uyUDvd47tPa', DB_URL: 'ecto://dash:dash_manager@localhost/dash_prod'
set :deploy_to, '/home/deploy/www/dash-blog'
set :log_level, :debug
set :keep_releases, 2

set :linked_files, fetch(:linked_files, []).push('config/prod.secret.exs')
set :linked_dirs, fetch(:linked_dirs, [])
  .push('deps', 'node_modules', 'rel', '_build', 'priv/static/css', 'priv/static/js')

task :dependencies do
  on roles(:web) do |_host|
    within(current_path) do
      execute(:mix, 'local.hex', '--force')
      execute(:mix, 'local.rebar', '--force')
      execute(:mix, 'deps.get')
    end
  end
end

# Run manually as needed
namespace :node do
  task :dependencies do
    on roles(:web) do |_host|
      within(current_path) do
        execute(:npm, 'install')
      end
    end
  end
end

task :build do
  on roles(:web) do |_host|
    within(current_path) do
      execute(:mix, 'release')
    end
  end
end

task :clean do
  on roles(:web) do |_host|
    within(current_path) do
      execute(:mix, 'deps.clean', '--all')
    end
  end
end

task :assets do
  on roles(:web) do |_host|
    within(current_path) do
      execute(:brunch, 'build', '--production')
      execute(:mix, 'phoenix.digest')
    end
  end
end

task :migrations do
  on roles(:web) do |_host|
    within(current_path) do
      execute(:mix, 'ecto.migrate')
    end
  end
end

task :start do
  on roles(:web) do |_host|
    within("#{current_path}/rel/dash/bin") do
      execute('./dash', 'start')
    end
  end
end

task :stop do
  on roles(:web) do |_host|
    within("#{current_path}/rel/dash/bin") do
      execute('./dash', 'stop')
    end
  end
end

task :restart do
  on roles(:web) do |_host|
    invoke('stop')
    invoke('start')
  end
end

before :build, :dependencies
before :build, 'node:dependencies'
before :build, :assets
after 'deploy:published', :build
# after "deploy:published", :restart
