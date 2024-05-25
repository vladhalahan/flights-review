# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalApi::Poke::StatsRetriever do
  let(:name) { 'pikachu' }
  let(:retriever) { described_class.new(name: name) }
  let(:client) { instance_double(ExternalApi::BaseClient) }
  let(:response) { instance_double(HTTParty::Response, success?: true, parsed_response: parsed_response) }
  let(:parsed_response) do
    {
      'abilities' => [
        { 'ability' => { 'name' => 'static' } },
        { 'ability' => { 'name' => 'lightning-rod' } },
      ],
      'sprites' => { 'front_default' => 'https://example.com/pikachu.png' },
      'stats' => [
        { 'stat' => { 'name' => 'speed' }, 'base_stat' => 90 },
        { 'stat' => { 'name' => 'attack' }, 'base_stat' => 55 },
      ]
    }
  end

  before do
    allow(ExternalApi::BaseClient).to receive(:new).and_return(client)
    allow(client).to receive(:run).and_return(response)
  end

  describe '#retrieve' do
    context 'when the response is successful' do
      it 'processes the response with ResponseProcessor' do
        processor = instance_double(ExternalApi::Poke::ResponseProcessor)
        processed_response = {
          abilities: %w[static lightning-rod],
          image_url: 'https://example.com/pikachu.png',
          stats: [
            { 'speed' => 90 },
            { 'attack' => 55 },
          ]
        }
        allow(ExternalApi::Poke::ResponseProcessor).to receive(:new).and_return(processor)
        allow(processor).to receive(:process_response).and_return(processed_response)

        result = retriever.retrieve

        expect(result).to eq(processed_response)
      end
    end

    context 'when the response is not successful' do
      let(:response) { instance_double(HTTParty::Response, success?: false) }

      it 'returns the failed response' do
        result = retriever.retrieve

        expect(result).to eq(response)
      end
    end
  end

  describe '#endpoint' do
    it 'returns the correct endpoint URL' do
      expect(retriever.send(:endpoint)).to eq("https://pokeapi.co/api/v2/pokemon/#{name}")
    end
  end

  describe '#client' do
    it 'initializes a new ExternalApi::BaseClient with the correct endpoint and method' do
      expect(ExternalApi::BaseClient).to receive(:new).with(endpoint: "https://pokeapi.co/api/v2/pokemon/#{name}", method: :get)
      retriever.send(:client)
    end
  end

  describe '#retrieve_stats' do
    it 'calls client.run and processes the response when successful' do
      processor = instance_double(ExternalApi::Poke::ResponseProcessor)
      allow(ExternalApi::Poke::ResponseProcessor).to receive(:new).and_return(processor)
      allow(processor).to receive(:process_response).with(response: response)

      retriever.send(:retrieve_stats)

      expect(client).to have_received(:run)
      expect(processor).to have_received(:process_response).with(response: response)
    end

    it 'returns the response when unsuccessful' do
      allow(response).to receive(:success?).and_return(false)

      result = retriever.send(:retrieve_stats)

      expect(result).to eq(response)
    end
  end
end
