class AddImageToBeacons < ActiveRecord::Migration
  def change
    add_column :beacons, :image, :string
  end
end
