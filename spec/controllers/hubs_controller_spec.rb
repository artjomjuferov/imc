require "rails_helper"

RSpec.describe HubsController do
  describe "GET index" do
    subject { get :index, params: { filter: filter }  }
    let!(:hub) { create(:hub, name_wo_diacritics: 'Hamburg') }

    context 'when filter match the hub' do
      let(:filter) { {name_wo_diacritics: 'Hamburg'} }
      specify do
        subject
        expect(response.status).to eq(200)
        expect(assigns(:hubs)).to contain_exactly(hub)
      end
    end

    context 'when filter does not match the hub' do
      let(:filter) { {name_wo_diacritics: 'Riga'} }
      specify do
        subject
        expect(response.status).to eq(200)
        expect(assigns(:hubs)).to be_empty
      end
    end
  end
end
