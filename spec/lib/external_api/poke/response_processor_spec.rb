# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalApi::Poke::ResponseProcessor do
  let(:processor) { described_class.new }

  describe '#process_response' do
    let(:response) { instance_double(HTTParty::Response, parsed_response: parsed_response, success?: true, code: 200) }
    let(:parsed_response) do
      {
        'abilities' => [
          { 'ability' => { 'name' => 'overgrow' } },
          { 'ability' => { 'name' => 'chlorophyll' } },
        ],
        'sprites' => { 'front_default' => 'https://example.com/sprite.png' },
        'stats' => [
          { 'stat' => { 'name' => 'speed' }, 'base_stat' => 60 },
          { 'stat' => { 'name' => 'attack' }, 'base_stat' => 80 },
        ]
      }
    end

    it 'returns a hash with abilities, image_url, and stats' do
      result = processor.process_response(response: response)

      expect(result).to eq(
        abilities: %w[overgrow chlorophyll],
        image_url: 'https://example.com/sprite.png',
        stats: [
          { 'speed' => 60 },
          { 'attack' => 80 },
        ]
      )
    end

    context 'when abilities are missing' do
      let(:parsed_response) { { 'sprites' => { 'front_default' => 'https://example.com/sprite.png' }, 'stats' => [] } }

      it 'returns an empty abilities array' do
        result = processor.process_response(response: response)

        expect(result[:abilities]).to eq([])
      end
    end

    context 'when sprite is missing' do
      let(:parsed_response) { { 'abilities' => [], 'stats' => [] } }

      it 'returns nil for image_url' do
        result = processor.process_response(response: response)

        expect(result[:image_url]).to be_nil
      end
    end

    context 'when stats are missing' do
      let(:parsed_response) { { 'abilities' => [], 'sprites' => { 'front_default' => 'https://example.com/sprite.png' } } }

      it 'returns an empty stats array' do
        result = processor.process_response(response: response)

        expect(result[:stats]).to eq([])
      end
    end
  end
end
