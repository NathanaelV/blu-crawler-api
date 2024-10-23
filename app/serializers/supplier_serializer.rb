class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :name, :cnpj, :slug

  has_many :categories
  has_many :states
end
