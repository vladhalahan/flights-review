# frozen_string_literal: true

class AddAvarageScoreToAirline < ActiveRecord::Migration[7.0]
  def change
    add_column :airlines, :average_score, :integer, default: 0
  end
end
