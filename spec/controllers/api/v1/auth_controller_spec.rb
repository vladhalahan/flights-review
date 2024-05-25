# frozen_string_literal: true

# spec/requests/api/v1/auth_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :request do
  let(:user) { create(:user) }

  describe 'POST /api/v1/auth' do
    context 'with valid credentials' do
      it 'logs in the user and returns success' do
        post '/api/v1/auth', params: { user: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:ok)
        expect(json['status']).to eq('success')
        expect(json['logged_in']).to be true
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      it 'returns an error' do
        post '/api/v1/auth', params: { user: { email: user.email, password: 'wrong_password' } }

        expect(response).to have_http_status(:bad_request)
        expect(json['status']).to eq('error')
        expect(json['logged_in']).to be false
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'DELETE /api/v1/auth/logout' do
    before do
      post '/api/v1/auth', params: { user: { email: user.email, password: user.password } }
    end

    it 'logs out the user' do
      delete '/api/v1/auth/logout'

      expect(response).to have_http_status(:ok)
      expect(json['logged_in']).to be false
      expect(session[:user_id]).to be_nil
    end
  end

  describe 'GET /api/v1/auth/me' do
    context 'when user is logged in' do
      before do
        post '/api/v1/auth', params: { user: { email: user.email, password: user.password } }
      end

      it 'returns the logged-in user info' do
        get '/api/v1/auth/me'

        expect(response).to have_http_status(:ok)
        expect(json['logged_in']).to be true
        expect(json['email']).to eq(user.email)
        expect(json['role']).to eq(user.role)
      end
    end

    context 'when no user is logged in' do
      it 'returns logged_in as false' do
        get '/api/v1/auth/me'

        expect(response).to have_http_status(:ok)
        expect(json['logged_in']).to be false
      end
    end
  end
end
