require "rails_helper"

RSpec.describe Location, type: :model do
  describe 'validations' do
    it { is_expected.to validate_numericality_of(:long).is_greater_than(-180) }
    it { is_expected.to validate_numericality_of(:long).is_less_than(180) }
    it { is_expected.to validate_presence_of(:long) }

    it { is_expected.to validate_numericality_of(:lat).is_greater_than(-90) }
    it { is_expected.to validate_numericality_of(:lat).is_less_than(90) }
    it { is_expected.to validate_presence_of(:lat) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:hub) }
  end
end
