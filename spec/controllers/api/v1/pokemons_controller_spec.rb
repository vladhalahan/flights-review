# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PokemonsController, type: :request do
  let(:user) { create(:user, :admin) }
  let(:pokemon) { create(:pokemon) }

  before do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
  end

  describe 'GET /api/v1/pokemons' do
    it 'returns a list of pokemons' do
      get '/api/v1/pokemons'

      expect(response).to have_http_status(:ok)
      expect(json['data'].size).to eq(Pokemon.count)
    end
  end

  describe 'GET /api/v1/pokemons/:slug' do
    it 'returns the specified pokemon' do
      get "/api/v1/pokemons/#{pokemon.slug}"

      expect(response).to have_http_status(:ok)
      expect(json['data']['id']).to eq(pokemon.id.to_s)
    end
  end

  describe 'POST /api/v1/pokemons' do
    it 'creates a new pokemon' do
      pokemon_params = {
        pokemon: {
          name: 'Pikachu',
          image_url: 'https://example.com/pikachu.png'
        }
      }

      post '/api/v1/pokemons', params: pokemon_params

      expect(response).to have_http_status(:ok)
      expect(json['data']).to have_key('id')
      expect(json['data']['attributes']['name']).to eq('Pikachu')
    end
  end

  describe 'DELETE /api/v1/pokemons/:slug' do
    it 'deletes the specified pokemon' do
      delete "/api/v1/pokemons/#{pokemon.slug}"

      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('Destroyed successfully')
    end
  end
end
