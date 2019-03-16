require "rails_helper"

RSpec.describe Function, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code).scoped_to(:hub_id) }
    it { is_expected.to validate_inclusion_of(:code).in_array(%w[0 1 2 3 4 5 6 7 B]) }
  end

  describe '.explanation' do
    subject { Function.explanation(code) }

    context 'with 1 code' do
      let(:code) { '1' }
      it { is_expected.to eq('Port (for any kind of waterborne transport)') }
    end

    context 'with 2 code' do
      let(:code) { '2' }
      it { is_expected.to eq('Rail terminal') }
    end

    context 'with 3 code' do
      let(:code) { '3' }
      it { is_expected.to eq('Road terminal') }
    end

    context 'with 4 code' do
      let(:code) { '4' }
      it { is_expected.to eq('Airport') }
    end

    context 'with 5 code' do
      let(:code) { '5' }
      it { is_expected.to eq('Postal exchange office') }
    end

    context 'with 6 code' do
      let(:code) { '6' }
      it { is_expected.to eq('Inland Clearance Depot – ICD or "Dry Port", "Inland Clearance Terminal", etc.') }
    end

    context 'with 7 code' do
      let(:code) { '7' }
      it { is_expected.to eq('Fixed transport functions (e.g. oil platform)"; the classifier "7" is reserved for this function. Noting that the description "oil pipeline terminal" would be more relevant, and could be extended to cover also electric power lines and ropeway terminals.') }
    end

    context 'with B code' do
      let(:code) { 'B' }
      it { is_expected.to eq('Border crossing function') }
    end

    context 'with 0 code' do
      let(:code) { '0' }
      it { is_expected.to eq('Function not known, to be specified') }
    end
  end
end
