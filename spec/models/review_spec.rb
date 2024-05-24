# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it 'belongs to an airline' do
      expect(described_class.reflect_on_association(:airline).macro).to eq :belongs_to
    end
  end

  describe 'callbacks' do
    let(:airline) { create(:airline) }
    let(:user) { create(:user) }
    let(:review) { build(:review, user:, airline:) }

    it 'calls calculate_average on the airline after commit' do
      expect(airline).to receive(:calculate_average).once
      review.save!
    end

    it 'calls calculate_average on the airline after update' do
      review.save!
      expect(airline).to receive(:calculate_average).once
      review.update!(description: 'Updated content')
    end

    it 'calls calculate_average on the airline after destroy' do
      review.save!
      expect(airline).to receive(:calculate_average).once
      review.destroy
    end
  end
end
