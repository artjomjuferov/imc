module FillDbServices
  class FunctionsCreator
    def initialize(cell, hub_id)
      @cell = cell
      @hub_id = hub_id
    end

    def perform!
      @cell.gsub('-', '').split('').each { |code| create_function(code) }
    end

    private

    def create_function(code)
      Function.create(hub_id: @hub_id, code: code)
    end
  end
end
