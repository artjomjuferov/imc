require './lib/tasks/fill_db_services/hub_creator'

module FillDbServices
  class Creator
    def initialize(row)
      @row = row
      @log = Logger.new('fill_db.log')
    end

    def perform!
      country? ? create_country : create_hub
    rescue ActiveRecord::RecordInvalid => e
      @log.error(e.to_s)
      @log.error(@row)
    end

    private

    def country?
      @row[1] && !@row[2] && @row[3] && !@row[4]
    end

    def create_country
      Country.create(name: country_name, code: @row[1])
    end

    def create_hub
      HubCreator.new(@row).perform!
    end

    def country_name
      @row[3][1..-1].titleize
    end
  end
end
