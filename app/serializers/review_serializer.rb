# frozen_string_literal: true

class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score, :airline_id, :created_at

  attribute :email do |object|
    object&.user&.email
  end
end
