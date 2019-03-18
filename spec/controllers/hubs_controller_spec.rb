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

  describe "GET closest" do
    subject { get :closets  }
    let!(:hub) { create(:hub) }

    it 'finds the closest one' do
      subject
      expect(response.status).to eq(200)
      expect(assigns(:hubs)).to contain_exactly(hub)
    end
  end

  describe "GET autocomplete_address" do
    subject { get :autocomplete_address, term: 'Entered address' }

    it do
      expect(Geocoder).to receive(:search)
        .with('Entered address')
        .and_return(['Street name, Country, etc..'])

      subject
      expect(response.status).to eq(200)
      expect(response.json).to eq(['Street name, Country, etc..'])
    end
  end
end
