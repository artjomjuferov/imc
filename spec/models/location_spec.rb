require "rails_helper"

RSpec.describe Location, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:longlat) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:hub) }
  end
end
