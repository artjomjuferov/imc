class FunctionHub < ApplicationRecord
  validates :code, uniqueness: { scope: :hub_id },
                   inclusion: { in: %w[0 1 2 3 4 5 6 7 B] },
                   presence: true
  belongs_to :hub
end
