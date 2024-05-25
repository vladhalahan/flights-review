# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it 'belongs to an pokemon' do
      expect(described_class.reflect_on_association(:pokemon).macro).to eq :belongs_to
    end
  end

  describe 'callbacks' do
    let(:pokemon) { create(:pokemon) }
    let(:user) { create(:user) }
    let(:review) { build(:review, user:, pokemon:) }

    it 'calls calculate_average on the pokemon after commit' do
      expect(pokemon).to receive(:calculate_average).once
      review.save!
    end

    it 'calls calculate_average on the pokemon after update' do
      review.save!
      expect(pokemon).to receive(:calculate_average).once
      review.update!(description: 'Updated content')
    end

    it 'calls calculate_average on the pokemon after destroy' do
      review.save!
      expect(pokemon).to receive(:calculate_average).once
      review.destroy
    end
  end
end
