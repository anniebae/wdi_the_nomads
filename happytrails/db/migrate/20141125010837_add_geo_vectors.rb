class AddGeoVectors < ActiveRecord::Migration
  def change
      ########### Yaniv Comment ###########
      # See comment in Create Trails migration
      #####################################
  	add_column :trails, :drivingfrombarclayscentermiles, :integer
  	add_column :trails, :drivingfrombarclayscenterseconds, :integer
  	add_column :trails, :drivingfromalbanymiles, :integer
  	add_column :trails, :drivingfromalbanyseconds, :integer

  	add_column :trails, :cyclingfrombarclayscentermiles, :integer
  	add_column :trails, :cyclingfrombarclayscenterseconds, :integer
  	add_column :trails, :cyclingfromalbanymiles, :integer
  	add_column :trails, :cyclingfromalbanyseconds, :integer
  	add_column :trails, :walkingfrombarclayscentermiles, :integer
  	add_column :trails, :walkingfrombarclayscenterseconds, :integer
  	add_column :trails, :walkingfromalbanymiles, :integer
  	add_column :trails, :walkingfromalbanyseconds, :integer
  end
end
