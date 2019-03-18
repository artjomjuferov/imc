class HubsController < ApplicationController
  def index
    @hubs = IndexFilter
              .new(index_filter_params)
              .results
              .paginate(:page => params[:page])
              .preload(:functions, :location, :country)

  end

  def closest
    p address_params
    @hubs = Hub.limit(1)
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
