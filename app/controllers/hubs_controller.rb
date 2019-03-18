class HubsController < ApplicationController
  def index
    @hubs = IndexFilter
              .new(index_filter_params)
              .results
              .paginate(:page => params[:page])
              .preload(:functions, :location, :country)

  end

  def closest
    pp Geocoder.search(params[:address])
    @hubs = Hub.limit(1)
  end

  def autocomplete_address
    res =  Geocoder.search(params[:term]).map do |geocoder|
      address = geocoder.data['address']
      [
        address['statation'], address['road'], address['suburb'],
        address['city_district'], address['city'], address['town'],
        address['county'], address['state'], address['country']
      ].compact.join(',')
    end
    render json: res
  end

  private

  def index_filter_params
    params.fetch(:filter, {})
  end
end
