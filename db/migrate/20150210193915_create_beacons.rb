class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.string :name
      t.string :factory_id
      t.text :description
      t.decimal :latitude
      t.decimal :longitude
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
