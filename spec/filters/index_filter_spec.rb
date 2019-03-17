require "rails_helper"

RSpec.describe IndexFilter do
  subject { described_class.new(params).results }

  context 'when params is empty' do
    let!(:hub) { create(:hub) }
    let(:params) { {} }
    it { is_expected.to contain_exactly(hub) }
  end

  describe 'searching by name_wo_diacritics' do
    let!(:hub) { create(:hub, name_wo_diacritics: 'Hamburg') }
    let(:params) { {name_wo_diacritics: name} }

    context 'with empty' do
      let(:name) { '' }
      it { is_expected.to contain_exactly(hub) }
    end

    context 'with existing' do
      let(:name) { 'Hamburg' }
      it { is_expected.to contain_exactly(hub) }
    end

    context 'with non existing' do
      let(:name) { 'Riga' }
      it { is_expected.to be_empty }
    end
  end

  describe 'searching by unlocode' do
    let!(:hub) { create(:hub, unlocode: 'DE HAM') }
    let(:params) { {unlocode: unlocode} }

    context 'with empty' do
      let(:unlocode) { '' }
      it { is_expected.to contain_exactly(hub) }
    end

    context 'with existing' do
      let(:unlocode) { 'DE HAM' }
      it { is_expected.to contain_exactly(hub) }
    end

    context 'with non existing' do
      let(:unlocode) { 'DD HHM' }
      it { is_expected.to be_empty }
    end
  end

  describe 'searching by change_codes' do
    let!(:hub1) { create(:hub, change_code: '+', name: 'Hamburg', name_wo_diacritics: 'Hamburg', code: 'HAM') }
    let!(:hub2) { create(:hub, change_code: '#', name: 'Riga', name_wo_diacritics: 'Riga', code: 'RIX') }
    let(:params) { {change_codes: change_codes} }

    context 'with empty array' do
      let(:change_codes) { [] }
      it { is_expected.to contain_exactly(hub1, hub2) }
    end

    context 'when existsing' do
      let(:change_codes) { %w[+ #] }
      it { is_expected.to contain_exactly(hub1, hub2) }
    end

    context 'with non existsing' do
      let(:change_codes) { %w[!] }
      it { is_expected.to be_empty }
    end
  end

  describe 'searching by statuses' do
    let!(:hub1) { create(:hub, status: 'AA', name: 'Hamburg', name_wo_diacritics: 'Hamburg', code: 'HAM') }
    let!(:hub2) { create(:hub, status: 'AC', name: 'Riga', name_wo_diacritics: 'Riga', code: 'RIX') }
    let(:params) { {statuses: change_codes} }

    context 'with empty array' do
      let(:statuses) { [] }
      it { is_expected.to contain_exactly(hub1, hub2) }
    end

    context 'when existsing' do
      let(:statuses) { %w[AA AC] }
      it { is_expected.to contain_exactly(hub1, hub2) }
    end

    context 'with non existing' do
      let(:statuses) { %w[AF] }
      it { is_expected.to be_empty }
    end
  end

  describe 'searching by functions' do
    let!(:hub1) { create(:hub, name: 'Hamburg', name_wo_diacritics: 'Hamburg', code: 'HAM') }
    let!(:function_hub1) { create(:function, hub: hub1, code: '1') }
    let!(:hub2) { create(:hub, name: 'Riga', name_wo_diacritics: 'Riga', code: 'RIX') }
    let!(:function_hub2) { create(:function, hub: hub1, code: '2') }
    let(:params) { {functions: functions} }

    context 'with empty array' do
      let(:functions) { [] }
      it { is_expected.to contain_exactly(hub1, hub2) }
    end

    context 'when existsing' do
      let(:statuses) { %w[1 2] }
      it { is_expected.to contain_exactly(hub1, hub2) }
    end

    context 'with non existing' do
      let(:statuses) { %w[3] }
      it { is_expected.to be_empty }
    end

    context 'when functions_and is passed' do
      let!(:second_function_hub1) { create(:function, hub: hub1, code: '2') }
      let(:statuses) { %w[1 2] }
      it { is_expected.to contain_exactly(hub1) }
    end
  end
end
