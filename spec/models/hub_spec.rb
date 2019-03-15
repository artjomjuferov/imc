require "rails_helper"

RSpec.describe Hub, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }

    it { is_expected.to validate_presence_of(:name_wo_diacritics) }
    it { is_expected.to validate_uniqueness_of(:name_wo_diacritics) }

    it { is_expected.to validate_presence_of(:subdiv) }

    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(%w[AA AC AF AI AM AQ AS RL RN RQ UR RR QQ XX]) }

    it { is_expected.to validate_presence_of(:uploaded_date) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:country) }
    it { is_expected.to have_one(:location) }
    it { is_expected.to have_many(:functions) }
  end
end
