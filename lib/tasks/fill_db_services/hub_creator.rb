require './lib/tasks/fill_db_services/functions_creator'
require './lib/tasks/fill_db_services/location_creator'

module FillDbServices
  class HubCreator
    def initialize(row)
      @row = row
    end

    def perform!
      @hub = create_hub
      create_functions
      create_location
    end

    private

    def create_hub
      Hub.create!(
        change_code: @row[0],
        country: country,
        code: @row[2],
        name: @row[3],
        name_wo_diacritics: @row[4],
        subdiv: @row[5],
        status: @row[7],
        uploaded_date: uploaded_date,
        iata: @row[9],
        remark: @row[11],
      )
    end

    def create_functions
      FunctionsCreator.new(@row[6], @hub.id).perform!
    end

    def create_location
      LocationCreator.new(@row[10], @hub.id).perform!
    end

    def country
      Country.find_by(code: @row[1])
    end

    def uploaded_date
      Date.strptime(@row[8], "%y%m") if @row[8]
    end
  end
end
