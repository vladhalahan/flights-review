# frozen_string_literal: true

class ReviewPolicy < ApplicationPolicy

  def create?
    user.regular?
  end

  def destroy?
    record.user_id == user.id
  end

end
