namespace :db do
  desc "Load the barclays csv data into the trails db"
  task :pass_information_from_csv => :environment do
    csvaddress = "./lib/barclaysdata_backup.csv"

    puts "hello"

    CSV.foreach(csvaddress, :headers => true) do |row_in_csv_file|
      pp row_in_csv_file
      trail = Trail.find(row_in_csv_file['id'])
      trail.drivingfrombarclayscenterseconds = row_in_csv_file["drivingfrombarclayscenterseconds"]
      trail.drivingfrombarclayscentermiles = row_in_csv_file["drivingfrombarclayscentermiles"]
      trail.cyclingfrombarclayscenterseconds = row_in_csv_file["cyclingfrombarclayscenterseconds"]
      trail.cyclingfrombarclayscentermiles = row_in_csv_file["cyclingfrombarclayscentermiles"]
      trail.walkingfrombarclayscenterseconds = row_in_csv_file["walkingfrombarclayscenterseconds"]
      trail.walkingfrombarclayscentermiles = row_in_csv_file["walkingfrombarclayscentermiles"]
      trail.geocoordinates = row_in_csv_file["geocoordinates"]
      trail.save
    end
  end
end
