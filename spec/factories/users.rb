require 'faker'

FactoryGirl.define do
  factory :logist, class: User do
    email "logist@email.com"
    pwd = Faker::Internet.password(8)
    password pwd
    password_confirmation pwd
    first_name { Faker::Internet.user_name }
    last_name { Faker::Internet.user_name }
    after(:create) do |user|
      user.add_role :logist
    end
  end
  
  factory :admin, class: User do
    email "admin@email.com"
    pwd = Faker::Internet.password(8)
    password pwd
    password_confirmation pwd
    first_name { Faker::Internet.user_name }
    last_name { Faker::Internet.user_name }
    after(:create) do |user|
      user.add_role :admin
    end
  end
  
  factory :distributor, class: User do
    email "distributor@email.com"
    pwd = Faker::Internet.password(8)
    password pwd
    password_confirmation pwd
    first_name { Faker::Internet.user_name }
    last_name { Faker::Internet.user_name }
    after(:create) do |user|
      user.add_role :distributor
    end
  end
end
