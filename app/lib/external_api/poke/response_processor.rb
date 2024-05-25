# frozen_string_literal: true

module ExternalApi
  module Poke
    # Responsible for response processing retrieved from PokeAPI endpoint
    class ResponseProcessor

      # Calling only on success response in Retriever class
      def process_response(response:)
        parsed_response = response.parsed_response

        abilities = parsed_response['abilities']&.map { |ability| ability.dig('ability', 'name') } || []
        sprite_url = parsed_response.dig('sprites', 'front_default')
        stats = parsed_response['stats']&.map { |stat| { stat.dig('stat', 'name') => stat['base_stat'] } } || []

        {
          abilities: abilities,
          image_url: sprite_url,
          stats: stats
        }
      end
    end
  end
end
