# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :string
#  score       :integer
#  airline_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Review < ApplicationRecord
  belongs_to :airline
end
