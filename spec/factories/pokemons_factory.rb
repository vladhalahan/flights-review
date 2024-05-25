# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    name { 'Fake Pokemon' }
    slug { 'fake-pokemon' }
  end
end
