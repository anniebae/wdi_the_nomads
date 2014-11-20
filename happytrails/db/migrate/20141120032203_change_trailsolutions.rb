class ChangeTrailsolutions < ActiveRecord::Migration
  def change
    change_table(:trailsolutions) do |t|
      t.remove :prop_ID, :name, :location, :park_name, :other_details, :accessible, :limited_access
      t.string :park, :title, :region, :state, :dogs, :lat, :lon
      t.text :features
    end
  end
end
