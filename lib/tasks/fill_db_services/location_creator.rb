require './lib/tasks/fill_db_services/location_creators/dms_to_dd'

module FillDbServices
  class LocationCreator
    def initialize(cell, hub_id)
      @cell = cell
      @hub_id = hub_id
    end

    def perform!
      return if @cell.blank?
      Location.create(hub_id: @hub_id, longlat: "POINT(#{dd[:long]} #{dd[:lat]})")
    end
    
    def dd
      @dd ||= LocationCreators::DmsToDd.new(@cell).convert
    end
  end
end
