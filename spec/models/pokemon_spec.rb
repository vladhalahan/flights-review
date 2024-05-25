# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe 'associations' do
    it 'has many reviews dependent on destroy' do
      expect(described_class.reflect_on_association(:reviews).macro).to eq :has_many
      expect(described_class.reflect_on_association(:reviews).options[:dependent]).to eq :destroy
    end
  end

  describe 'callbacks' do
    describe '#slugify' do
      let(:pokemon) { build(:pokemon, name: 'Test Pokemon') }

      it 'creates a slug from the name before create' do
        pokemon.save
        expect(pokemon.slug).to eq('test-pokemon')
      end
    end
  end

  describe '#calculate_average' do
    let(:pokemon) { create(:pokemon) }

    context 'when there are no reviews' do
      it 'returns 0 and does not update the average_score' do
        expect(pokemon.calculate_average).to eq(0)
        expect(pokemon.average_score).to eq(0)
      end
    end

    context 'when there are reviews' do
      before do
        create(:user)
        create(:review, pokemon:, user: User.last, score: 5)
        create(:review, pokemon:, user: User.last, score: 3)
      end

      it 'calculates the average score of all reviews and updates the average_score' do
        pokemon.calculate_average
        expect(pokemon.average_score).to eq(400.0)
      end
    end
  end
end
