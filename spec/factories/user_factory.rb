# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'Password!23' }
    role { 'regular' }

    trait :admin do
      role { 'admin' }
    end
  end
end
