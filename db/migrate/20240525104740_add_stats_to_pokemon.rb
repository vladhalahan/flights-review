# frozen_string_literal: true

class AddStatsToPokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :abilities, :text
    add_column :pokemons, :stats, :text
  end
end
