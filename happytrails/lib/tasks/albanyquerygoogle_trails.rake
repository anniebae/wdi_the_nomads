namespace :db do

  desc "pull the Albany dataset"

  task :googlealbanypopulate_trails => :environment do
    Trail.stagealbanyny
  end
end
