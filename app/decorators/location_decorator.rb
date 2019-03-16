class LocationDecorator < Draper::Decorator
  def map_link
    href = "https://www.google.com/maps/search/?api=1&query=#{object.lat},#{object.long}"
    "<a href='#{href}'>Show on map</a>"
  end
end
