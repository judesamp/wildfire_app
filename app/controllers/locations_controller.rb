class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def new
    @new_location = Location.new
    @new_location.wildfires.build
  end

  def show
    @location = Location.find(params[:id])
  end

  def create
    @new_location = Location.create(location_params)
    if @new_location.save
      redirect_to locations_path
    else
      redirect_to new_location_path
    end
  end

  def location_params
    params.require(:location).permit(:name, :unit, :dedicated_wildfire_unit, wildfires_attributes: [ :incident ])
  end

end
