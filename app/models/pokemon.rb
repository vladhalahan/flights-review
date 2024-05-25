# frozen_string_literal: true

# == Schema Information
#
# Table name: pokemons
#
#  id            :bigint           not null, primary key
#  average_score :integer          default(0)
#  image_url     :string
#  name          :string
#  slug          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Pokemon < ApplicationRecord
  has_many :reviews, dependent: :destroy

  before_create :slugify

  validates :name, uniqueness: true

  def slugify
    self.slug = name.parameterize
  end

  # Get the average score of all reviews for an pokemon
  def calculate_average
    return 0 unless reviews.size.positive?

    avg = reviews.average(:score).to_f.round(2) * 100
    self.average_score = avg
    save!
  end
end
