# frozen_string_literal: true

class AddAvarageScoreToPokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :average_score, :integer, default: 0
  end
end
