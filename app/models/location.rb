class Location < ApplicationRecord
  validates :long, numericality: {less_than: 180, greater_than: -180}, presence: true
  validates :lat, numericality: {less_than: 90, greater_than: -90}, presence: true

  belongs_to :hub
end
