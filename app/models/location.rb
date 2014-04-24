class Location < ActiveRecord::Base
  has_many :wildfires
  accepts_nested_attributes_for :wildfires
end 
