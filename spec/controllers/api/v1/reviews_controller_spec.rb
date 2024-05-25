# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :request do
  let(:user) { create(:user) }
  let(:pokemon) { create(:pokemon) }

  before do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
  end

  describe 'POST /api/v1/reviews' do
    it 'creates a new review' do
      review_params = {
        review: {
          title: 'Great game!',
          description: 'Really enjoyed playing this game.',
          score: 5,
          pokemon_id: pokemon.id
        }
      }

      post '/api/v1/reviews', params: review_params

      expect(response).to have_http_status(:ok)
      expect(json['data']).to have_key('id')
      expect(json['data']['attributes']['title']).to eq('Great game!')
      expect(json['data']['attributes']['score']).to eq(5)
      expect(json['data']['attributes']['pokemon_id']).to eq(pokemon.id)
    end
  end

  describe 'DELETE /api/v1/reviews/:id' do
    let(:review) { create(:review, user:, pokemon:) }

    context 'when user owns the review' do
      it 'deletes the review' do
        delete "/api/v1/reviews/#{review.id}"

        expect(response).to have_http_status(:ok)
        expect(json['message']).to eq('Destroyed successfully')
      end
    end
  end
end
