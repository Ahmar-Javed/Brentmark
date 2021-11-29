class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  include PgSearch::Model
  pg_search_scope :search, against: [:final_price]

end
