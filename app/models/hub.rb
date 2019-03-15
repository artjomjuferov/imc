class Hub < ApplicationRecord
  STATUSES = %w[AA AC AF AI AM AQ AS RL RN RQ UR RR QQ XX]

  validates :name, presence: true, uniqueness: true
  validates :name_wo_diacritics, presence: true, uniqueness: true
  validates :subdiv, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :uploaded_date, presence: true

  belongs_to :country
  has_one :location
  has_many :functions
end
