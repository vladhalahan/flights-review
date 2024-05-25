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
    context 'when the request is valid' do
      let(:pokemon_params) do
        {
          pokemon: {
            name: 'Pikachu',
          }
        }
      end
      let(:pokemon) { create(:pokemon, name: pokemon_params[:pokemon][:name], slug: pokemon_params[:pokemon][:name].parameterize) }
      let(:command) { instance_double(Pokemons::Create, success?: true, result: pokemon) }

      before do
        allow(Pokemons::Create).to receive(:call).and_return(command)
      end

      it 'creates a new pokemon' do
        post '/api/v1/pokemons', params: pokemon_params

        expect(response).to have_http_status(:ok)
        expect(json['data']).to have_key('id')
        expect(json['data']['attributes']['name']).to eq('Pikachu')
      end
    end

    context 'when the request is invalid' do
      let(:pokemon_params) do
        {
          pokemon: {
            name: '',
            image_url: 'https://example.com/pikachu.png'
          }
        }
      end
      let(:errors) { { name: ["can't be blank"] } }
      let(:command) { instance_double(Pokemons::Create, success?: false, errors: errors) }

      before do
        allow(Pokemons::Create).to receive(:call).and_return(command)
      end

      it 'returns validation errors' do
        post '/api/v1/pokemons', params: pokemon_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq(errors.stringify_keys)
      end
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
