class HubDecorator < Draper::Decorator
  def unlocode
    "#{object.country.code} #{object.code}"
  end
end
