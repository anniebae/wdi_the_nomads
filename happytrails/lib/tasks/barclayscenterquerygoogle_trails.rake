namespace :db do

  desc "pull the barclays center dataset"

  task :googlebarclayscenterpopulate_trails => :environment do
    Trail.stagebarclayscenter
  end
end
