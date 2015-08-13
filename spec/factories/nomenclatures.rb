# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :nomenclature do
    name { Faker::Lorem.word }
    partner_number { Faker::Lorem.characters(10) }
  end
end
