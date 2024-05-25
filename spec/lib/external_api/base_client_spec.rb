# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalApi::BaseClient do
  describe '#initialize' do
    it 'sets default values' do
      client = described_class.new(endpoint: 'http://example.com')
      expect(client.endpoint).to eq('http://example.com')
      expect(client.header_options).to eq({})
      expect(client.open_timeout_seconds).to eq(described_class::DEFAULT_OPEN_TIMEOUT_SECONDS)
      expect(client.read_timeout_seconds).to eq(described_class::DEFAULT_READ_TIMEOUT_SECONDS)
    end

    it 'sets provided values' do
      client = described_class.new(endpoint: 'http://example.com', header_options: { 'Authorization' => 'Bearer token' })
      expect(client.endpoint).to eq('http://example.com')
      expect(client.header_options).to eq({ 'Authorization' => 'Bearer token' })
    end
  end

  describe '#run' do
    let(:client) { described_class.new(endpoint: 'http://example.com') }

    it 'makes a request' do
      expect(HTTParty).to receive(:post).with('http://example.com', anything)
      client.run
    end

  end

  describe '#request_options' do
    let(:client) { described_class.new(endpoint: 'http://example.com') }

    it 'returns request options hash' do
      options = client.send(:request_options, body: { key: 'value' }, query: { param: 'value' })
      expect(options).to eq({
                              headers: described_class.default_headers,
                              body: { key: 'value' },
                              query: { param: 'value' },
                              open_timeout: described_class::DEFAULT_OPEN_TIMEOUT_SECONDS,
                              timeout: described_class::DEFAULT_READ_TIMEOUT_SECONDS
                            })
    end

    it 'does not include nil values' do
      options = client.send(:request_options)
      expect(options).to eq({
                              headers: described_class.default_headers,
                              open_timeout: described_class::DEFAULT_OPEN_TIMEOUT_SECONDS,
                              timeout: described_class::DEFAULT_READ_TIMEOUT_SECONDS
                            })
    end
  end

  describe '#headers' do
    let(:client) { described_class.new(endpoint: 'http://example.com') }

    it 'merges default and header options' do
      client.header_options = { 'Authorization' => 'Bearer token' }
      expect(client.send(:headers)).to eq({
                                            'Content-Type' => 'application/json',
                                            'Authorization' => 'Bearer token'
                                          })
    end
  end
end
