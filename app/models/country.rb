class Country < ApplicationRecord
  validates :name, uniqueness: true
  validates :code, uniqueness: true
end
