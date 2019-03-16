require "rails_helper"
require './lib/tasks/fill_db_services/functions_creator.rb'

RSpec.describe FillDbServices::FunctionsCreator do
  describe '#perform' do
    subject { described_class.new(cell, hub_id).perform! }

    let(:hub_id) { create(:hub).id }
    let(:cell) { '1-3----B' }

    specify do
      expect { subject }.to change(Function, :count).from(0).to(3)
      %w[1 3 B].each do |code|
        expect(Function.find_by(code: code)).to have_attributes(hub_id: hub_id)
      end
    end
  end
end
