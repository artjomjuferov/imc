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

  def self.change_code_explanation(change_code)
    case change_code
    when 'X'
      'Marked for deletion in the next issue'
    when '#'
      'Change in location name (usually spelling)'
    when '¦'
      'Other changes in the entry (not location)'
    when '+'
      'Entry added to the current issue'
    when '='
      'Reference entry'
    when '!'
      'Retained for certain entries in the USA code list ("controlled duplications")'
    end
  end

  def self.status_explanation(status)
    case status
    when 'AA'
      'Approved by competent national government agency'
    when 'AC'
      'Approved by Customs Authority'
    when 'AF'
      'Approved by national facilitation body'
    when 'AI'
      'Code adopted by international organisation (IATA or ECLAC)'
    when 'AM'
      'Approved by the UN/LOCODE Maintenance Agency'
    when 'AQ'
      'Entry approved, functions not verified'
    when 'AS'
      'Approved by national standardisation body'
    when 'RL'
      'Recognised location - Existence and representation of location name confirmed by check against nominated gazetteer or other reference work'
    when 'RN'
      'Request from credible national sources for locations in their own country'
    when 'RQ'
      'Request under consideration'
    when 'UR'
      "Entry included on user's request; not officially approved"
    when 'RR'
      'Request rejected'
    when 'QQ'
      'Original entry not verified since date indicated'
    when 'XX'
      'Entry that will be removed from the next issue of UN/LOCODE'
    end
  end
end
