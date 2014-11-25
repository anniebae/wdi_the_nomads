namespace :db do

  desc "pull the barclays center dataset"

  task :googlegcpopulate_trails => :environment do
    Trail.stagebarclayscenter
  end
end
