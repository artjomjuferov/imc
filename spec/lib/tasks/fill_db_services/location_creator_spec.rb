require "rails_helper"
require './lib/tasks/fill_db_services/location_creator.rb'

RSpec.describe FillDbServices::LocationCreator do
  describe '#perform' do
    subject { described_class.new(cell, hub_id).perform! }

    let(:hub_id) { create(:hub).id }
    let(:cell) { '' }

    specify do
      expect { subject }.to change(Location, :count).from(0).to(1)
      # TODO: fix it
      expect(Location.last).to have_attributes(lat: 0, long: 0, hub_id: hub_id)
    end
  end
end
