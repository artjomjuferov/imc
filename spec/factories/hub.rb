FactoryBot.define do
  factory :hub do
    country
    code { 'HAM' }
    name { 'Hamburg' }
    name_wo_diacritics { 'Hamburg' }
    subdiv { 'HH' }
    status { 'AF' }
    uploaded_date { Date.new }
  end
end
