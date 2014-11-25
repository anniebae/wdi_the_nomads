namespace :db do
	desc "Load the csv data into the trails db"
	task :pass_information_from_csv => :environment do
		csvaddress = "./lib/data_tape_load.csv"

		CSV.foreach(csvaddress, :headers => true) do |row_in_csv_file|
			pp row_in_csv_file
			trail = Trail.find(row_in_csv_file['id'])
			trail.drivingfromgrandcentralseconds = row_in_csv_file["drivingfromgrandcentralseconds"]
			trail.drivingfromgrandcentralmiles = row_in_csv_file["drivingfromgrandcentralmiles"]
			trail.cyclingfromgrandcentralseconds = row_in_csv_file["cyclingfromgrandcentralseconds"]
			trail.cyclingfromgrandcentralmiles = row_in_csv_file["cyclingfromgrandcentralmiles"]
			trail.walkingfromgrandcentralseconds = row_in_csv_file["walkingfromgrandcentralseconds"]
			trail.walkingfromgrandcentralmiles = row_in_csv_file["walkingfromgrandcentralmiles"]
			trail.drivingfrombarclayscenterseconds = row_in_csv_file["drivingfrombarclayscenterseconds"]
			trail.drivingfrombarclayscentermiles = row_in_csv_file["drivingfrombarclayscentermiles"]
			trail.drivingfromalbanyseconds = row_in_csv_file["drivingfromalbanyseconds"]
			trail.drivingfromalbanymiles = row_in_csv_file["drivingfromalbanymiles"]
			trail.walkingfrombarclayscenterseconds = row_in_csv_file["walkingfrombarclayscenterseconds"]
			trail.walkingfrombarclayscentermiles = row_in_csv_file["walkingfrombarclayscentermiles"]
			trail.walkingfromalbanyseconds = row_in_csv_file["walkingfromalbanyseconds"]
			trail.walkingfromalbanymiles = row_in_csv_file["walkingfromalbanymiles"]
			trail.cyclingfrombarclayscenterseconds = row_in_csv_file["cyclingfrombarclayscenterseconds"]
			trail.cyclingfrombarclayscentermiles = row_in_csv_file["cyclingfrombarclayscentermiles"]
			trail.cyclingfromalbanyseconds = row_in_csv_file["cyclingfromalbanyseconds"]
			trail.cyclingfromalbanymiles = row_in_csv_file["cyclingfromalbanymiles"]
			trail.geocoordinates = row_in_csv_file["geocoordinates"]
			trail.save
		end
	end
end
