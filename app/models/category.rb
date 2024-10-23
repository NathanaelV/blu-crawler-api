class Category < ApplicationRecord
  include ActiveModel::Serialization

  has_and_belongs_to_many :suppliers
end
