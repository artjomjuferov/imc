require 'rails_helper'

RSpec.describe FunctionDecorator, type: :decorator do
  describe '#humane' do
    subject { function.decorate.humane }
    let(:hub) { build(:hub) }
    let(:function) { Function.new(hub: hub, code: code)}

    context 'with 1 code' do
      let(:code) { '1' }
      it { is_expected.to eq('(1) Port (for any kind of waterborne transport)') }
    end
  end
end
