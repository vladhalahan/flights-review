# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'associations' do
    it 'has many reviews dependent on destroy' do
      expect(described_class.reflect_on_association(:reviews).macro).to eq :has_many
      expect(described_class.reflect_on_association(:reviews).options[:dependent]).to eq :destroy
    end
  end

  describe 'callbacks' do
    describe '#slugify' do
      let(:airline) { build(:airline, name: 'Test Airline') }

      it 'creates a slug from the name before create' do
        airline.save
        expect(airline.slug).to eq('test-airline')
      end
    end
  end

  describe '#calculate_average' do
    let(:airline) { create(:airline) }

    context 'when there are no reviews' do
      it 'returns 0 and does not update the average_score' do
        expect(airline.calculate_average).to eq(0)
        expect(airline.average_score).to eq(0)
      end
    end

    context 'when there are reviews' do
      before do
        create(:review, airline:, score: 5)
        create(:review, airline:, score: 3)
      end

      it 'calculates the average score of all reviews and updates the average_score' do
        airline.calculate_average
        expect(airline.average_score).to eq(400.0)
      end
    end
  end
end
