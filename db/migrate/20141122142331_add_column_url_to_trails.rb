class AddColumnUrlToTrails < ActiveRecord::Migration
  def change
    add_column :trails, :img, :string
  end
end
