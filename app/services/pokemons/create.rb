# frozen_string_literal: true

module Pokemons
  class Create
    prepend SimpleCommand

    def initialize(pokemon_params = {})
      @pokemon = Pokemon.new(pokemon_params)
    end

    def call
      assign_data
      return pokemon if pokemon.save

      errors.add(:errors, pokemon.errors.messages)
    end

    private

    attr_reader :pokemon

    def assign_data
      stats = retriever.retrieve
      data = { slug: pokemon.name.parameterize }

      pokemon.assign_attributes(data.merge(stats))
    end

    def retriever
      @retriever ||= ExternalApi::Poke::StatsRetriever.new(name: pokemon.name)
    end
  end
end
