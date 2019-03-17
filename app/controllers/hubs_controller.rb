class HubsController < ApplicationController
  def index
    @hubs = IndexFilter
              .new(index_filter_params)
              .results
              .paginate(:page => params[:page])
              .preload(:functions, :location, :country)

  end

  def closest
    @hubs = [Hub.first]
  end

  private

  def index_filter_params
    params.fetch(:filter, {})
  end
end
