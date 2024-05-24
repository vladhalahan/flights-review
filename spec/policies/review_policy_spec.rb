# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewPolicy do
  subject { described_class }

  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:review) { create(:review, user:) }
  let(:other_user) { create(:user, email: 'other@user.com') }
  let(:other_review) { create(:review, user: other_user) }

  permissions :create? do
    it 'grants access if user is regular' do
      expect(subject).to permit(user)
    end

    it 'denies access if user is not regular' do
      expect(subject).not_to permit(admin)
    end
  end

  permissions :destroy? do
    it 'grants access if user is the owner of the review' do
      expect(subject).to permit(user, review)
    end

    it 'denies access if user is not the owner of the review' do
      expect(subject).not_to permit(user, other_review)
    end
  end
end
