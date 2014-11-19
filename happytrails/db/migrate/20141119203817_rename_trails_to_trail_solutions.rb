class RenameTrailsToTrailSolutions < ActiveRecord::Migration
  def change
    rename_table :trails, :trailsolutions
  end
end
