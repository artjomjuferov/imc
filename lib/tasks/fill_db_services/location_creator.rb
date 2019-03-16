module FillDbServices
  class LocationCreator
    def initialize(cell, hub_id)
      @cell = cell
      @hub_id = hub_id
    end

    def perform!
      Location.create(hub_id: @hub_id, lat: lat, long: long)
    end

    private

    # TODO: fix it
    def lat
      0
    end

    # TODO: fix it
    def long
      0
    end
  end
end
