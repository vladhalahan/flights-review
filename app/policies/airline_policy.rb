# frozen_string_literal: true

class AirlinePolicy < ApplicationPolicy

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
