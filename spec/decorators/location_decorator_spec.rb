require 'rails_helper'

RSpec.describe LocationDecorator, type: :decorator do
  let(:hub) { build(:hub) }
  let(:location) { Location.new(hub: hub, longlat: 'POINT(2 1)') }

  describe '#map_link' do
    subject { location.decorate.map_link }
    it { is_expected.to eq("<a href='https://www.google.com/maps/search/?api=1&query=1.0,2.0'>Show on map</a>") }
  end
  
  describe '#map_link' do
    subject { location.decorate.humane }
    it { is_expected.to eq('1.0, 2.0') }
  end
end
