class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :geocoordinates
      t.string :url
      t.string :park
      t.string :title
      t.string :region
      t.string :state
      t.string :length
      t.string :difficulty
      t.string :dogs
      t.string :lat
      t.string :lon
      t.text :features
      t.integer :drivingfromgrandcentralmiles
      t.integer :drivingfromgrandcentralseconds
      t.integer :cyclingfromgrandcentralmiles
      t.integer :cyclingfromgrandcentralseconds
      t.integer :walkingfromgrandcentralmiles
      t.integer :walkingfromgrandcentralseconds
      t.timestamps
    end
  end
end