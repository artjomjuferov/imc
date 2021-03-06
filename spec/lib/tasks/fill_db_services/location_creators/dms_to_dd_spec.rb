require "rails_helper"
require './lib/tasks/fill_db_services/location_creators/dms_to_dd.rb'

RSpec.describe FillDbServices::LocationCreators::DmsToDd do
  describe '#perform' do
    subject { described_class.new(dms).convert }

    describe 'directions' do
      context 'when long E' do
        let(:dms) { '5231N 01323E' }
    
        specify do
          expect(subject[:lat]).to be_within(0.1).of(52.516667)
          expect(subject[:long]).to be_within(0.1).of(13.383333)
        end
      end
  
      context 'when long W' do
        let(:dms) { '5231N 01323W' }
    
        specify do
          expect(subject[:lat]).to be_within(0.1).of(52.516667)
          expect(subject[:long]).to be_within(0.1).of(-13.383333)
        end
      end
      
      context 'when lat S' do
        let(:dms) { '5231S 01323E' }
    
        specify do
          expect(subject[:lat]).to be_within(0.1).of(-52.516667)
          expect(subject[:long]).to be_within(0.1).of(13.383333)
        end
      end
  
      context 'when long N' do
        let(:dms) { '5231N 01323W' }
    
        specify do
          expect(subject[:lat]).to be_within(0.1).of(52.516667)
          expect(subject[:long]).to be_within(0.1).of(-13.383333)
        end
      end
    end

    describe 'formats' do
      context 'when not leading 0' do
        let(:dms) { '5231N 15259E' }
    
        specify do
          expect(subject[:lat]).to be_within(0.1).of(52.516667)
          expect(subject[:long]).to be_within(0.1).of(15.4191)
        end
      end
    end
  end
end
