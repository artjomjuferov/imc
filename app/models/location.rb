class Location < ApplicationRecord
  validates :longlat, presence: true
  
  belongs_to :hub
end
