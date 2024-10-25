class State < ApplicationRecord
  include ActiveModel::Serialization

  has_and_belongs_to_many :suppliers

  validates :slug, uniqueness: true
end
