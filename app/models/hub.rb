class Hub < ApplicationRecord
  STATUSES = %w[AA AC AF AI AM AQ AS RL RN RQ UR RR QQ XX]
  CHANGE_CODES = %w[X # ¦ + = !]

  validates :change_code, allow_nil:true, inclusion: {in: CHANGE_CODES}
  validates :unlocode, presence:true
  validates :code, presence: true, uniqueness: {scope: :country_id}
  validates :name, presence: true, uniqueness: {scope: :country_id}
  validates :name_wo_diacritics, presence: true, uniqueness: {scope: :country_id}
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :uploaded_date, presence: true

  belongs_to :country
  has_one :location
  has_many :functions
end
