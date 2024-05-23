# frozen_string_literal: true

# == Schema Information
#
# Table name: airlines
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Airline < ApplicationRecord
  has_many :reviews, dependent: :destroy

  before_create :slugify

  def slugify
    self.slug = name.parameterize
  end

  # def avg_score
  #   reviews.average(:score).to_f.round(2)
  # end
end
