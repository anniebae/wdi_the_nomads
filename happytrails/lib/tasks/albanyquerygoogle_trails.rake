namespace :db do

  desc "pull the Albany dataset"

  task :googlegcpopulate_trails => :environment do
    Trail.stagealbanyny
  end
end
