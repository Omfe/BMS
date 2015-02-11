class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.string :image
      t.text :description
      t.string :type

      t.timestamps null: false
    end
  end
end
