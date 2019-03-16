class HubDecorator < Draper::Decorator
  def unlocode
    "#{object.country.code} #{object.code}"
  end

  def change_code_humane
    case object.change_code
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
end
