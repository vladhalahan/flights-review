# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewSerializer, type: :serializer do
  describe 'serialization' do
    let(:airline) { create(:airline) }
    let(:review) { create(:review, title: 'Great Service', description: 'Excellent flight experience', score: 5, airline:) }
    let(:serializer) { described_class.new(review) }
    let(:serialization) { serializer.serializable_hash }

    it 'includes the expected attributes' do
      expect(serialization[:data][:attributes]).to include(
        title: 'Great Service',
        description: 'Excellent flight experience',
        score: 5,
        airline_id: airline.id
      )
    end
  end
end
