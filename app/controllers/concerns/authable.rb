# frozen_string_literal: true

module Authable
  extend ActiveSupport::Concern

  included do
    # before_action :current_user
  end

  def current_user
    return nil unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    true
    # render json: { error: 'Access Denied' }, status: :unauthorized unless current_user
  end
end
