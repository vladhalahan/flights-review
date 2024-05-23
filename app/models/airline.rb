# frozen_string_literal: true

class Airline < ApplicationRecord
  has_many :reviews, dependent: :destroy

  before_create :slugify

  def slugify
    self.slug = name.parameterize
  end

  def avg_score
    reviews.average(:score).to_f.round(2)
  end
end
