require "rails_helper"
require './lib/tasks/fill_db_services/location_creator.rb'
require './lib/tasks/fill_db_services/location_creators/dms_to_dd.rb'

RSpec.describe FillDbServices::LocationCreator do
  describe '#perform' do
    subject { described_class.new(cell, hub_id).perform! }

    let(:cell) { '' }
    let(:hub_id) { create(:hub).id }

    specify do
      expect(FillDbServices::LocationCreators::DmsToDd)
        .to receive_message_chain(:new, :convert)
        .and_return(lat: 0, long: 0)
      expect { subject }.to change(Location, :count).from(0).to(1)
      expect(Location.last).to have_attributes(lat: 0, long: 0, hub_id: hub_id)
    end
  end
end
