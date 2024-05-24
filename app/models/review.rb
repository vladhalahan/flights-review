# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  description :string
#  score       :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  airline_id  :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_reviews_on_airline_id  (airline_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (airline_id => airlines.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :airline
  belongs_to :user

  validates :title, :score, presence: true

  # Recalculate the average score for a parent airline
  # whenever a review is created/updated/destroyed
  after_commit ->(review) { review.airline.calculate_average }
end
