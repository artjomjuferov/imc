class Function < ApplicationRecord
  CODES = %w[0 1 2 3 4 5 6 7 B]

  validates :code, presence: true,
                   uniqueness: { scope: :hub_id },
                   inclusion: { in: CODES }

  belongs_to :hub
end
