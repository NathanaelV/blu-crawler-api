class Supplier < ApplicationRecord
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :states
end
