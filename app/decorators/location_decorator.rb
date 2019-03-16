class LocationDecorator < Draper::Decorator
  delegate_all

  def map_link
    href = "https://www.google.com/maps/search/?api=1&query=#{object.lat},#{object.long}"
    "<a href='#{href}'>Show on map</a>".html_safe
  end
end
