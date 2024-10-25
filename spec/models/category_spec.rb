require 'rails_helper'

RSpec.describe Category do
  describe '#valid?' do
    it 'slug must be uniq' do
      Category.create!(slug: 'bicicleta')

      category = Category.new(slug: 'bicicleta')
      category.valid?

      expect(category).not_to be_valid
      expect(category.errors[:slug]).to include('has already been taken')
    end
  end
end
