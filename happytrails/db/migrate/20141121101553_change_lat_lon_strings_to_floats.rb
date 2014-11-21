class ChangeLatLonStringsToFloats < ActiveRecord::Migration
  def change
    remove_column :trails, :lat
    remove_column :trails, :lon
    add_column :trails, :lat, :float
    add_column :trails, :lon, :float
  end
end
