class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :unit
      t.boolean :dedicated_wildfire_unit, default: false

      t.timestamps
    end
  end
end
