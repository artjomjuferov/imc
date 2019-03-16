class Function < ApplicationRecord
  CODES = %w[0 1 2 3 4 5 6 7 B]

  validates :code, presence: true,
                   uniqueness: { scope: :hub_id },
                   inclusion: { in: CODES }

  belongs_to :hub

  def self.explanation(code)
    case code
    when '1'
      'Port (for any kind of waterborne transport)'
    when '2'
      'Rail terminal'
    when '3'
      'Road terminal'
    when '4'
      'Airport'
    when '5'
      'Postal exchange office'
    when '6'
      'Inland Clearance Depot – ICD or "Dry Port", "Inland Clearance Terminal", etc.'
    when '7'
      'Fixed transport functions (e.g. oil platform)"; the classifier "7" is reserved for this function. Noting that the description "oil pipeline terminal" would be more relevant, and could be extended to cover also electric power lines and ropeway terminals.'
    when 'B'
      'Border crossing function'
    when '0'
      'Function not known, to be specified'
    end
  end
end
