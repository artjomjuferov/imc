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
    subject { get :closest, params: {address: address} }
    let!(:closest_hub) { create(:hub, name: 'Closest') }
    let!(:closest_location) { create(:location, longlat: 'POINT(1.111 2.222)', hub: closest_hub) }
    let!(:farthest_hub) { create(:hub, name: 'Farthest', country: Country.first) }
    let!(:farthest_location) { create(:location, longlat: 'POINT(1.112 2.223)', hub: farthest_hub) }
   
    context 'with correct address' do
      let(:address) { {name: 'Incorrect', lat: '', long: ''} }
      it 'finds the closest one' do
        subject
        expect(response.status).to eq(200)
        expect(assigns(:hubs)).to be_empty
      end
    end
    
    context 'with correct address' do
      let(:address) { {name: 'Correct one', lat: '2.22', long: '1.11'} }
      it 'finds the closest one' do
        subject
        expect(response.status).to eq(200)
        expect(assigns(:hubs)).to contain_exactly(closest_hub)
      end
    end
  end

  describe "GET autocomplete_address" do
    subject { get :autocomplete_address, params: {term: 'Entered address'} }

    it do
      expect(Geocoder).to receive(:search)
        .with('Entered address')
        .and_return([double(address:'address', coordinates: [1.1, 2.2])])

      subject
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(['value' => 'address', 'data' => [1.1, 2.2]])
    end
  end
end
