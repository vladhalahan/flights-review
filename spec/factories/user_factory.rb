# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'regular' }

    trait :admin do
      role { 'admin' }
    end
  end
end
