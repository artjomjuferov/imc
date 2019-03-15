require "rails_helper"

RSpec.describe FunctionHub, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:code).scoped_to(:hub_id) }
    it { is_expected.to validate_inclusion_of(:code).in_array(%w[0 1 2 3 4 5 6 7 B]) }
  end
end
