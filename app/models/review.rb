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
#  pokemon_id  :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_reviews_on_pokemon_id  (pokemon_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (pokemon_id => pokemons.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user

  validates :title, :score, presence: true

  # Recalculate the average score for a parent pokemon
  # whenever a review is created/updated/destroyed
  after_commit ->(review) { review.pokemon.calculate_average }
end
