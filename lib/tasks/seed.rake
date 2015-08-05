namespace :db do
  desc 'Load fixture data into the cache'
  task :seed do
    load './db/seeds.rb'
  end
end
