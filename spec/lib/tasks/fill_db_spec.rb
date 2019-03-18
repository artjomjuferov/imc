require "rails_helper"
require './lib/tasks/fill_db'
require './lib/tasks/fill_db_services/hub_creator.rb'
require './lib/tasks/fill_db_services/location_creator.rb'
require './lib/tasks/fill_db_services/functions_creator.rb'

RSpec.describe FillDb do
  subject { described_class.new('tmp/unlcode').perform! }

  specify do
    expect(Dir).to receive(:[]).and_return(['path_to_file_1'])
    expect(CSV).to receive(:foreach)
      .and_yield([nil, 'DE', nil, '.GERMANY', nil, nil])
      .and_yield(['+', 'DE', 'HAM', 'Hamburg', 'Hamburg', 'HH', '12345---', 'AF', '0210', 'QAJ', '2560N 05533E', 'Remark'])

    expect { subject }
      .to change(Country, :count).from(0).to(1)
      .and change(Hub, :count).from(0).to(1)
      .and change(Location, :count).from(0).to(1)
      .and change(Function, :count).from(0).to(5)

    country = Country.last
    expect(country).to have_attributes(code: 'DE', name: 'Germany')

    hub = Hub.last
    expect(hub).to have_attributes(
      change_code: '+',
      country_id: country.id,
      unlocode: 'DE HAM',
      code: 'HAM',
      name: 'Hamburg',
      name_wo_diacritics: 'Hamburg',
      subdiv: 'HH',
      status: 'AF',
      uploaded_date: Date.new(2002, 10),
      iata: 'QAJ',
      remark: 'Remark'
    )

    location = Location.last 
    expect(location.hub_id).to eq(hub.id)
    expect(location.longlat.lon).to eq(55.55)
    expect(location.longlat.lat).to eq(26)

    (1..5).each do |code|
      expect(Function.find_by(code: code).hub_id).to eq(hub.id)
    end
  end
end
