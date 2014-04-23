class AddDefaultValueToStatusInWildfires < ActiveRecord::Migration
  def change
    change_column :wildfires, :status, :string, :default => "active"
  end
end
