FactoryBot.define do
  factory :location do
    hub
    longlat { 'POINT(0, 1)' }
  end
end
