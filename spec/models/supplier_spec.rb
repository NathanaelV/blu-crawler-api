require 'rails_helper'

RSpec.describe Supplier do
  describe '#valid?' do
    it 'slug must be uniq' do
      Supplier.create!(slug: 'caloi')

      supplier = Supplier.new(slug: 'caloi')
      supplier.valid?

      expect(supplier).not_to be_valid
      expect(supplier.errors[:slug]).to include('has already been taken')
    end
  end
end
