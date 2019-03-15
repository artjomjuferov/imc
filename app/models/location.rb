class Location < ApplicationRecord
  validates :long, presence: true,
                   numericality: {less_than: 180, greater_than: -180}
  validates :lat, presence: true,
                  numericality: {less_than: 90, greater_than: -90}

  belongs_to :hub
end
