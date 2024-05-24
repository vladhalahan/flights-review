# frozen_string_literal: true

class ApiController < ApplicationController
  include Authable
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: 'You have no permissions to perform this action' }, status: :unauthorized
  end
end
