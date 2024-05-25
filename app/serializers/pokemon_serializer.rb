# frozen_string_literal: true

class PokemonSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug, :image_url, :abilities, :stats

  attribute :average_score do |object|
    (object.average_score.to_f / 100).to_f.round(2)
  end

  has_many :reviews do |pokemon|
    pokemon.reviews.order(created_at: :desc)
  end
end
