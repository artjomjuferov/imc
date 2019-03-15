class Country < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :code, uniqueness: true, presence: true
end
