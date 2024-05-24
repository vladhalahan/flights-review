# frozen_string_literal: true

class AirlineSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug, :image_url

  attribute :average_score do |object|
    (object.average_score.to_f / 100).to_f.round(2)
  end

  has_many :reviews do |airline|
    airline.reviews.order(created_at: :desc)
  end
end
