namespace :db do

  desc "pull the barclays dataset"

  task :googlegcpopulate_trails => :environment do
    Trail.stagenewyork
  end
end
