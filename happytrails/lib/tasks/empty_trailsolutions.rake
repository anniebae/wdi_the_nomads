namespace :db do
  desc "empty trailsolutions"
  task :empty_trailsolutions => :environment do
    Trailsolution.destroy_all
  end
end
