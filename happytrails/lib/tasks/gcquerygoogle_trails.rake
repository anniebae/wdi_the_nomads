namespace :db do

	desc "pull the grand central dataset"

	task :googlegcpopulate_trails => :environment do
		Trail.stagegrandcentral
	end
end
