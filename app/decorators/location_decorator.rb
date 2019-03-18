class LocationDecorator < Draper::Decorator
  delegate_all

  def map_link
    google_base_url = 'https://www.google.com/maps/search/?api=1&query=' 
    href = google_base_url + "#{object.longlat.lat},#{object.longlat.lon}"
    "<a href='#{href}'>Show on map</a>".html_safe
  end
end
