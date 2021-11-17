class Category < ApplicationRecord
  has_many :products, dependant: :destroy
end
