class State < ApplicationRecord
  has_and_belongs_to_many :suppliers
end
