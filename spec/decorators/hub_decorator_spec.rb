require 'rails_helper'

RSpec.describe HubDecorator, type: :decorator do
  describe '#change_code_humane' do
    subject { hub.decorate.change_code_humane }

    let(:hub) { build(:hub, change_code: change_code) }

    context 'with X change_code' do
      let(:change_code) { 'X' }
      it { is_expected.to eq('(X) Marked for deletion in the next issue') }
    end
  end

  describe '#satatus_humane' do
    subject { hub.decorate.satatus_humane }

    let(:hub) { build(:hub, status: status) }

    context 'with AA status' do
      let(:status) { 'AA' }
      it { is_expected.to eq('(AA) Approved by competent national government agency') }
    end
  end
end
