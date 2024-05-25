# frozen_string_literal: true

module ExternalApi
  module Poke
    class StatsRetriever

      # @param [String] name - required parameter from PokeAPI
      def initialize(name:)
        @name = name
      end

      def retrieve
        retrieve_stats
      end

      private

      attr_reader :name

      def endpoint
        @endpoint ||= "https://pokeapi.co/api/v2/pokemon/#{name}"
      end

      def client
        @client ||= ExternalApi::BaseClient.new(endpoint: endpoint, method: :get)
      end

      def retrieve_stats
        response = client.run
        return failed_response(response) unless response.success?

        ResponseProcessor.new.process_response(response: response)
      end

      def failed_response(response)
        response
      end
    end
  end
end
