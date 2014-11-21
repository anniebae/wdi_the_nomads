namespace :db do
	
		desc "Load the csv data into the trails db"
		task :pass_information_from_csv => :environment do
			CSV.foreach(Rails.root + "lib/grandcentraldata_backup.csv", :headers => true) do |row_in_csv_file|
				trail = Trail.find(row_in_csv_file['id'])
				
				trail.drivingfromgrandcentralseconds = row_in_csv_file[:drivingfromgrandcentralseconds]
				trail.drivingfromgrandcentralmiles = row_in_csv_file[:drivingfromgrandcentralmiles]
				trail.cyclingfromgrandcentralseconds = row_in_csv_file[:cyclingfromgrandcentralseconds]
				trail.cyclingfromgrandcentralmiles = row_in_csv_file[:cyclingfromgrandcentralmiles]
				trail.walkingfromgrandcentralseconds = row_in_csv_file[:walkingfromgrandcentralseconds]
				trail.walkingfromgrandcentralmiles = row_in_csv_file[:walkingfromgrandcentralmiles]
				trail.geocoordinates = row_in_csv_file[:geocoordinates]
				trail.save
		end
	end
end
