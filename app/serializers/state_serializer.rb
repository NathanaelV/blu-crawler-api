class StateSerializer < ActiveModel::Serializer
  attributes :id, :name, :uf, :slug
end
