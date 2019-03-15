require "rails_helper"

RSpec.describe Country, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:code) }
  end
end
