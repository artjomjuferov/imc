require "rails_helper"
require './lib/tasks/fill_db_services/location_creators/dms_to_dd.rb'

RSpec.describe FillDbServices::LocationCreators::DmsToDd do
  describe '#perform' do
    subject { described_class.new(dms).convert }

    let(:dms) { '5231N, 01323E' }

    specify do
      expect(subject[:lat]).to be_within(0.1).of(52.516667)
      expect(subject[:long]).to be_within(0.1).of(13.383333)
    end
  end
end
