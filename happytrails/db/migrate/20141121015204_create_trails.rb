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
        ########### Yaniv Comment ###########
        # Hmmm... There are a few things that can be improved here.
        # First, let's get some underscores in the column names
        # and help maintain readability.
        # Second, it feels like we're just repeating the same line of
        # code over again 6 times... Could we DRY that up? 

        # Your saving this info in a table row.. But maybe they could
        # be a table in their own right? Maybe a Trail could have_many
        # LandmarkDistances, which would contain information about
        # the landmark, the distance to that landmark, and travel
        # time? It would both help DRY the code, and make it MUCH
        # more flexible in terms of adding future landmarks (plus,
        # it would let you sort them by distance!)
        #####################################
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