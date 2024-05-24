# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AirlinePolicy do
  subject { described_class }

  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  permissions :create?, :destroy? do
    it 'grants access if user is an admin' do
      expect(subject).to permit(admin)
    end

    it 'denies access if user is not an admin' do
      expect(subject).not_to permit(user)
    end
  end
end
