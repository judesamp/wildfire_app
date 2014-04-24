class AddFireImageToWildfires < ActiveRecord::Migration
  def change
    add_column :wildfires, :fire_image, :string
  end
end
