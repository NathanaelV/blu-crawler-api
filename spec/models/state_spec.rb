require 'rails_helper'

RSpec.describe State do
  describe '#valid?' do
    it 'slug must be uniq' do
      State.create!(slug: 'goias')

      state = State.new(slug: 'goias')
      state.valid?

      expect(state).not_to be_valid
      expect(state.errors[:slug]).to include('has already been taken')
    end
  end
end
