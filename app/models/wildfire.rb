class Wildfire < ActiveRecord::Base
  belongs_to :location
  mount_uploader :fire_image, FireImageUploader

  scope :active, -> { where(status: 'active') }
  scope :inactive, -> { where(status: 'inactive') }

  def self.search(params)
    state = params[:state]
    status = params[:status]
    acres = params[:acres]
    puts state
    search = Wildfire.all

    
    if state.present?
      search = Wildfire.joins(:location).where("locations.name Like ?", "%#{state}%")
    end

    if status.present?
      search = search.where('status LIKE ?', "%#{status}%")
    end

    if acres.present? 
      search = search.where('acres < ?', acres)
    end

    search
  end
  
end
