class AddUrlToTrailsolutions < ActiveRecord::Migration
  def change
    add_column :trailsolutions, :url, :string
  end
end
