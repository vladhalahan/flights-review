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
#
# Indexes
#
#  index_reviews_on_airline_id  (airline_id)
#
# Foreign Keys
#
#  fk_rails_...  (airline_id => airlines.id)
#
class Review < ApplicationRecord
  belongs_to :airline

  # Recalculate the average score for a parent airline
  # whenever a review is created/updated/destroyed
  after_commit ->(review) { review.airline.calculate_average }
end
