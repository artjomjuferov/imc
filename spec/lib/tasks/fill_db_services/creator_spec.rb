require "rails_helper"
require './lib/tasks/fill_db_services/creator.rb'
require './lib/tasks/fill_db_services/hub_creator.rb'

RSpec.describe FillDbServices::Creator do
  describe '#perform' do
    subject { described_class.new(row).perform! }

    context 'when it is a country' do
      let(:row) { [nil, 'DE', nil, '.GERMANY' ] }

      specify do
        expect { subject }.to change(Country, :count).from(0).to(1)
        expect(Country.last).to have_attributes(code: 'DE', name: 'Germany')
      end
    end

    context 'when it is a hub' do
      let(:row) { [nil, 'DE', 'LHX', '.GERMANY'] }

      it 'calls HubCreator' do
        expect(FillDbServices::HubCreator).to receive_message_chain(:new, :perform!)
        subject
      end
    end
  end
end
