# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AirlineSerializer, type: :serializer do
  describe 'serialization' do
    let(:airline) { create(:airline, name: 'Test Airline', slug: 'test-airline', image_url: 'http://example.com/image.png', average_score: 450) }
    let(:review1) { create(:review, airline:) }
    let(:review2) { create(:review, airline:) }
    let(:serializer) { described_class.new(airline) }
    let(:serialization) { serializer.serializable_hash }

    it 'includes the expected attributes' do
      expect(serialization[:data][:attributes]).to include(
        name: 'Test Airline',
        slug: 'test-airline',
        image_url: 'http://example.com/image.png',
        average_score: 4.5
      )
    end

    it 'includes the associated reviews' do
      review1
      review2
      expect(serialization[:data][:relationships][:reviews][:data].size).to eq(2)
      expect(serialization[:data][:relationships][:reviews][:data][0][:id]).to eq(review1.id.to_s)
      expect(serialization[:data][:relationships][:reviews][:data][1][:id]).to eq(review2.id.to_s)
    end
  end
end
