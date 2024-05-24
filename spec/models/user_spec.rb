# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many reviews dependent on destroy' do
      expect(described_class.reflect_on_association(:reviews).macro).to eq :has_many
      expect(described_class.reflect_on_association(:reviews).options[:dependent]).to eq :destroy
    end
  end

  describe 'validations' do
    it 'validates presence of email' do
      user = described_class.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email' do
      create(:user, email: 'test@example.com')
      user = described_class.new(email: 'test@example.com')
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'validates format of email' do
      user = described_class.new(email: 'invalid_email')
      user.valid?
      expect(user.errors[:email]).to include('is invalid')
    end
  end

  describe 'secure password' do
    it 'has a secure password' do
      user = described_class.new(email: 'test1@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to respond_to(:authenticate)
    end
  end

  describe 'roles' do
    it 'defines the roles enum' do
      expect(described_class.roles.keys).to contain_exactly('regular', 'admin')
    end

    it 'sets the default role to regular if not specified' do
      user = described_class.create(email: 'regular@example.com', password: 'password', password_confirmation: 'password')
      expect(user.role).to eq 'regular'
    end

    it 'allows setting the role to admin' do
      user = described_class.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'admin')
      expect(user.role).to eq 'admin'
    end
  end

  describe '#default_role' do
    it 'sets the default role if role is not present' do
      user = described_class.new(email: 'test3@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to receive(:default_role)
      user.save
    end

    it 'does not override the role if it is already set' do
      user = described_class.new(email: 'test4@example.com', password: 'password', password_confirmation: 'password', role: 'admin')
      expect(user).not_to receive(:default_role)
      user.save
      expect(user.role).to eq 'admin'
    end
  end
end
