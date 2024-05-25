# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemons::Create do
  let(:pokemon_params) { { name: 'Pikachu', image_url: 'https://example.com/pikachu.png' } }
  let(:command) { described_class.new(pokemon_params) }
  let(:pokemon) { instance_double(Pokemon, pokemon_params.merge(slug: 'pikachu', save: save_result)) }
  let(:retriever) { instance_double(ExternalApi::Poke::StatsRetriever, retrieve: stats) }
  let(:stats) { { abilities: %w[static lightning-rod], image_url: 'https://example.com/pikachu.png', stats: [{ speed: 90 }, { attack: 55 }] } }
  let(:save_result) { true }

  before do
    allow(Pokemon).to receive(:new).and_return(pokemon)
    allow(pokemon).to receive(:assign_attributes)
    allow(ExternalApi::Poke::StatsRetriever).to receive(:new).and_return(retriever)
  end

  describe '#call' do
    subject { command.call }

    context 'when the pokemon is successfully created' do
      it 'retrieves and assigns data to the pokemon' do
        subject
        expect(retriever).to have_received(:retrieve)
        expect(pokemon).to have_received(:assign_attributes).with({ slug: 'pikachu' }.merge(stats))
      end

      it 'saves the pokemon' do
        subject
        expect(pokemon).to have_received(:save)
      end

      it 'returns the pokemon' do
        expect(subject.result).to eq(pokemon)
      end
    end

    context 'when the pokemon fails to save' do
      let(:save_result) { false }
      let(:error_messages) { { name: ["can't be blank"] } }

      before do
        allow(pokemon).to receive(:errors).and_return(OpenStruct.new(messages: error_messages))
      end

      it 'adds errors to the command' do
        subject
        expect(command.errors[:errors]).to eq([error_messages])
      end

      it 'returns nil' do
        expect(subject.result).to be_nil
      end
    end
  end
end
