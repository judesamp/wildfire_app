class CreateWildfires < ActiveRecord::Migration
  def change
    create_table :wildfires do |t|
      t.string :incident
      t.integer :acres
      t.string :status
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :lng, {:precision=>10, :scale=>6}

      t.timestamps
    end
  end
end
