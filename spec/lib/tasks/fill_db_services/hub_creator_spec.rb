require "rails_helper"
require './lib/tasks/fill_db_services/hub_creator.rb'
require './lib/tasks/fill_db_services/location_creator.rb'
require './lib/tasks/fill_db_services/functions_creator.rb'

RSpec.describe FillDbServices::HubCreator do
  describe '#perform' do
    subject { described_class.new(row).perform! }

    let(:row) { ['+', 'DE', 'HAM', 'Hamburg', 'Hamburg', 'HH', '----', 'AF', '0210', 'QAJ', '2532N 05533E', 'Remark'] }
    let!(:country) { create(:country, code: 'DE', name: 'Germany') }

    specify do
      expect(FillDbServices::FunctionsCreator).to receive_message_chain(:new, :perform!)
      expect(FillDbServices::LocationCreator).to receive_message_chain(:new, :perform!)

      expect { subject }.to change(Hub, :count).from(0).to(1)
      expect(Hub.last).to have_attributes(
        change_code: '+',
        country_id: country.id,
        code: 'HAM',
        name: 'Hamburg',
        name_wo_diacritics: 'Hamburg',
        subdiv: 'HH',
        status: 'AF',
        uploaded_date: Date.new(2002, 10),
        iata: 'QAJ',
        remark: 'Remark'
      )
    end
  end

  describe '#uploaded_date' do
    subject { described_class.new(row).send(:uploaded_date) }
    let(:row) { ['+', 'DE', 'HAM', 'Hamburg', 'Hamburg', 'HH', '----', 'AF', time_row, 'QAJ', '2532N 05533E', 'Remark'] }
    context 'when row is nil' do
      let(:time_row) { nil }
      it { is_expected.to be_nil }
    end

    context 'when row has a valid value' do
      let(:time_row) { '0210' }
      it { is_expected.to eq(Date.new(2002, 10)) }
    end
  end
end
