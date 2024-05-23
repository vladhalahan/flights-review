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
      let(:airline) { described_class.new(name: 'Test Airline') }

      it 'creates a slug from the name before create' do
        airline.save
        expect(airline.slug).to eq('test-airline')
      end
    end
  end
end
