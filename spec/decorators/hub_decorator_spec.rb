require 'rails_helper'

RSpec.describe HubDecorator, type: :decorator do
  describe '#unlocode' do
    subject { hub.decorate.unlocode }
    let(:country) { build(:country, name: 'Germany', code: 'DE') }
    let(:hub) { build(:hub, country: country, code: 'HAM') }

    it { is_expected.to eq('DE HAM') }
  end

  describe '#change_code_humane' do
    subject { hub.decorate.change_code_humane }

    let(:hub) { build(:hub, change_code: change_code) }

    context 'with X change_code' do
      let(:change_code) { 'X' }
      it { is_expected.to eq('Marked for deletion in the next issue') }
    end

    context 'with # change_code' do
      let(:change_code) { '#' }
      it { is_expected.to eq('Change in location name (usually spelling)') }
    end

    context 'with ¦ change_code' do
      let(:change_code) { '¦' }
      it { is_expected.to eq('Other changes in the entry (not location)') }
    end

    context 'with + change_code' do
      let(:change_code) { '+' }
      it { is_expected.to eq('Entry added to the current issue') }
    end

    context 'with = change_code' do
      let(:change_code) { '=' }
      it { is_expected.to eq('Reference entry') }
    end

    context 'with ! change_code' do
      let(:change_code) { '!' }
      it { is_expected.to eq('Retained for certain entries in the USA code list ("controlled duplications")') }
    end
  end
end
