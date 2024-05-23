# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it 'belongs to an airline' do
      expect(described_class.reflect_on_association(:airline).macro).to eq :belongs_to
    end
  end
end
