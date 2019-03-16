require 'rails_helper'

RSpec.describe HubDecorator, type: :decorator do
  describe '#unlocode' do
    subject { hub.decorate.unlocode }
    let(:country) { create(:country, name: 'Germany', code: 'DE') }
    let(:hub) { create(:hub, country: country, code: 'HAM') }

    it { is_expected.to eq('DE HAM') }
  end
end
