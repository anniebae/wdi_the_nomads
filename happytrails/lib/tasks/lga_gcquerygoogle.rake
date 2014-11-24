namespace :db do

  desc "pull the lga dataset"

  task :googlegcpopulate_trails => :environment do
    Trail.stagenewyork
  end
end
