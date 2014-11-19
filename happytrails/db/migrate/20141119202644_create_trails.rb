class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.integer :prop_ID
      t.string :name
      t.string :location
      t.string :park_name
      t.string :length
      t.string :difficulty
      t.text :other_details
      t.boolean :accessible
      t.boolean :limited_access

      t.timestamps
    end
  end
end
