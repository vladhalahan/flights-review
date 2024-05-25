# frozen_string_literal: true

module ExternalApi
  # BaseClient for making HTTP requests.
  #
  # Dependencies:
  #   - HTTParty: Used for making HTTP requests to the API endpoint.
  class BaseClient
    DEFAULT_OPEN_TIMEOUT_SECONDS = 1
    DEFAULT_READ_TIMEOUT_SECONDS = 8

    class_attribute :default_headers, default: { 'Content-Type' => 'application/json' }

    attr_accessor :endpoint, :header_options, :open_timeout_seconds, :read_timeout_seconds

    def initialize(endpoint:, method: :post, header_options: {})
      @endpoint = endpoint
      @header_options = header_options
      @method = method
      @open_timeout_seconds = DEFAULT_OPEN_TIMEOUT_SECONDS
      @read_timeout_seconds = DEFAULT_READ_TIMEOUT_SECONDS
    end

    def run(body: nil, query_params: nil)
      make_request(body: body, query_params: query_params)
    end

    private

    attr_reader :method

    def make_request(body: nil, query_params: nil)
      HTTParty.send(method, endpoint, request_options(body: body, query: query_params))
    end

    def request_options(body: nil, query: nil)
      {
        headers: headers,
        body: body,
        query: query,
        open_timeout: open_timeout_seconds,
        timeout: read_timeout_seconds
      }.compact
    end

    def headers
      default_headers.merge(header_options)
    end
  end
end
