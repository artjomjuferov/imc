require './lib/tasks/fill_db_services/location_creators/dms_to_dd'

module FillDbServices
  class LocationCreator
    def initialize(cell, hub_id)
      @hub_id = hub_id
      @dd = LocationCreators::DmsToDd.new(cell).convert
    end

    def perform!
      Location.create(hub_id: @hub_id, lat: @dd[:lat], long: @dd[:long])
    end
  end
end
