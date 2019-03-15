class Location < ApplicationRecord
  validates_numericality_of :long, less_than: 180, greater_than: -180
  validates_numericality_of :lat, less_than: 90, greater_than: -90

  belongs_to :hub
end
