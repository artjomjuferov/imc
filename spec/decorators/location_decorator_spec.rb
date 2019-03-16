require 'rails_helper'

RSpec.describe LocationDecorator, type: :decorator do
  describe '#map_link' do
    subject { location.decorate.map_link }
    let(:hub) { build(:hub) }
    let(:location) { Location.new(hub: hub, lat: 1.0, long: 2.0)}

    it { is_expected.to eq("<a href='https://www.google.com/maps/search/?api=1&query=1.0,2.0'>Show on map</a>") }
  end
end
