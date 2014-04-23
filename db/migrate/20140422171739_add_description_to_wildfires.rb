class AddDescriptionToWildfires < ActiveRecord::Migration
  def change
    add_column :wildfires, :description, :text, :default => "It was a raging inferno!"
  end
end
