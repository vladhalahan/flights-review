# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokemonSerializer, type: :serializer do
  describe 'serialization' do
    let(:pokemon) { create(:pokemon, name: 'Test pokemon', slug: 'test-pokemon', image_url: 'http://example.com/image.png', average_score: 450) }
    let(:review1) { create(:review, pokemon:) }
    let(:serializer) { described_class.new(pokemon) }
    let(:serialization) { serializer.serializable_hash }

    it 'includes the expected attributes' do
      expect(serialization[:data][:attributes]).to include(
        name: 'Test pokemon',
        slug: 'test-pokemon',
        image_url: 'http://example.com/image.png',
        average_score: 4.5
      )
    end

    it 'includes the associated reviews' do
      review1
      expect(serialization[:data][:relationships][:reviews][:data].size).to eq(1)
      expect(serialization[:data][:relationships][:reviews][:data][0][:id]).to eq(review1.id.to_s)
    end
  end
end
