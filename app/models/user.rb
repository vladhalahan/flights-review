# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum roles: { regular: 'regular', admin: 'admin' }

  before_create :default_role, unless: -> { role.present? }

  def default_role
    self.role = User.roles[:regular]
  end

  # explicit defining of predicates methods is required since we use enum on string column
  roles.each_key do |role|
    define_method("#{role}?") do
      self.role == role
    end
  end
end
