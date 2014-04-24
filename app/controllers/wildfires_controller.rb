class WildfiresController < ApplicationController
  def index
    @wildfires = Wildfire.all
  end

  def new
    @new_wildfire = Wildfire.new
  end

  def create
    @new_wildfire = Wildfire.new(wildfire_params)
    if @new_wildfire.save
      redirect_to wildfires_path
    else
      redirect_to new_wildfire_path
    end
  end

  def edit
    @wildfire = Wildfire.find(params[:id])
  end

  def destroy
    @wildfire = Wildfire.find(params[:id])

    if @wildfire.delete
      redirect_to wildfires_path
    end
  end

  def show
    @wildfire = Wildfire.find(params[:id])
  end

  def update
    @wildfire = Wildfire.find(params[:id])
    if @wildfire.update_attributes(wildfire_params)
      redirect_to wildfires_path
    else
      redirect_to edit_wildfire_path #pass in id here? test later
    end
  end

  def active
    @wildfires = Wildfire.active
  end

  def inactive
    @wildfires = Wildfire.inactive
  end

  def change_status
    @wildfire = Wildfire.find(params[:id])
    if @wildfire.status == "active"
      val = "inactive"
      @wildfire.update_attributes(:status => val)
    else
      val = "active"
      @wildfire.update_attributes(:status => val)
    end
    redirect_to wildfires_path
  end

  def search 
  end

  # def process_search
  #   redirect_to results_wildfires_path(request.parameters)
  # end

  def results
    type = params[:search][:type]
    criteria = params[:search][:criteria]

    if type == "location"
      @results = Wildfire.joins(:location).where("name == ?", criteria)
    elsif type == "acres"
      @results = Wildfire.where("#{type} > ?", criteria)
    else
      @results = Wildfire.where(type.to_sym => criteria)
    end
  end

  def another_search
    search_string = params[:search]
    @results = Wildfire.joins(:location).where("name == ?", search_string)
  end

  def search_everything
    search_string = params[:search]
    @results = Wildfire.where("incident LIKE ? OR description LIKE ? OR status LIKE ?", "%#{search_string}%", "%#{search_string}%", "%#{search_string}%")
  end

  def chained_search
    state = params[:search][:state]
    status = params[:search][:status]

    @results = Wildfire.joins(:location).where("name LIKE ? AND status LIKE ?", state, status)
    render results_wildfires_path
  end

  def process_search
    redirect_to results_wildfires_path(request.parameters)
  end

  def scoped_search
    @results = Wildfire.search(params[:search])
    render results_wildfires_path
  end

  def download_fire_image
    @wildfire = Wildfire.find(params[:id])
    file = @wildfire.fire_image
    send_file file.path
  end

  private
  def wildfire_params
    params.require(:wildfire).permit(:incident, :acres, :status, :lat, :lng, :description, :location_id, :fire_image)
  end
end
