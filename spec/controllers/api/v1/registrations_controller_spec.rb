# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  describe 'POST /api/v1/registrations' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'creates a new user and returns success' do
        post '/api/v1/registrations', params: valid_params

        expect(response).to have_http_status(:ok)
        expect(json['status']).to eq('success')
        expect(json['logged_in']).to be true
        expect(User.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            email: '',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'returns an error' do
        post '/api/v1/registrations', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['status']).to eq('error')
        expect(json['logged_in']).to be false
        expect(User.count).to eq(0)
      end
    end
  end
end
