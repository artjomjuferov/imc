class HubsController < ApplicationController
  def index
    @hubs = Hubs::IndexSearch
              .new(index_filter_params)
              .results
              .paginate(:page => params[:page])
              .preload(:functions, :location, :country)

  end

  def closest
    lat = address_params[:lat]
    long = address_params[:long]
    if !lat.blank? && !long.blank?
      @hubs = Hub
        .joins(:location)
        .order("ST_Distance(locations.longlat, ST_MakePoint(#{long.to_f}, #{lat.to_f}))")
        .limit(1)
    else
      @hubs = []
    end
  end

  def autocomplete_address
    res =  Geocoder.search(params[:term]).map do |geocoder|
      {value: geocoder.address, data: geocoder.coordinates}
    end
    render json: res
  end

  private

  def index_filter_params
    params.fetch(:filter, {})
  end
  
  def address_params
    params.fetch(:address, {})
  end
end
