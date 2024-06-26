# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { 'This is the title' }
    description { 'This is the description' }
    score { 3 }

    user
    pokemon
  end
end
