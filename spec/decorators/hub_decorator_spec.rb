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

  describe '#satatus_humane' do
    subject { hub.decorate.satatus_humane }

    let(:hub) { build(:hub, status: status) }

    context 'with AA status' do
      let(:status) { 'AA' }
      it { is_expected.to eq('Approved by competent national government agency') }
    end

    context 'with AC status' do
      let(:status) { 'AC' }
      it { is_expected.to eq('Approved by Customs Authority') }
    end

    context 'with AF status' do
      let(:status) { 'AF' }
      it { is_expected.to eq('Approved by national facilitation body') }
    end

    context 'with AI status' do
      let(:status) { 'AI' }
      it { is_expected.to eq('Code adopted by international organisation (IATA or ECLAC)') }
    end

    context 'with AM status' do
      let(:status) { 'AM' }
      it { is_expected.to eq('Approved by the UN/LOCODE Maintenance Agency') }
    end

    context 'with AQ status' do
      let(:status) { 'AQ' }
      it { is_expected.to eq('Entry approved, functions not verified') }
    end

    context 'with AS status' do
      let(:status) { 'AS' }
      it { is_expected.to eq('Approved by national standardisation body') }
    end

    context 'with RL status' do
      let(:status) { 'RL' }
      it { is_expected.to eq('Recognised location - Existence and representation of location name confirmed by check against nominated gazetteer or other reference work') }
    end

    context 'with RN status' do
      let(:status) { 'RN' }
      it { is_expected.to eq('Request from credible national sources for locations in their own country') }
    end

    context 'with RQ status' do
      let(:status) { 'RQ' }
      it { is_expected.to eq('Request under consideration') }
    end

    context 'with UR status' do
      let(:status) { 'UR' }
      it { is_expected.to eq("Entry included on user's request; not officially approved") }
    end

    context 'with RR status' do
      let(:status) { 'RR' }
      it { is_expected.to eq('Request rejected') }
    end

    context 'with QQ status' do
      let(:status) { 'QQ' }
      it { is_expected.to eq('Original entry not verified since date indicated') }
    end

    context 'with XX status' do
      let(:status) { 'XX' }
      it { is_expected.to eq('Entry that will be removed from the next issue of UN/LOCODE') }
    end
  end
end
