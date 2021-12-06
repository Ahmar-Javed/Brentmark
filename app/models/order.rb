class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  enum status: { pending: 'pending', paid: 'paid' }

  include PgSearch::Model
  pg_search_scope :search, against: [:final_price]

  def buy_products
    self.pending!
    if self.save
      self.user.cart.cart_items.each do |cart_item|
        self.order_items.create(quantity: cart_item.quantity, product: cart_item.product)
      end
      self.user.cart.cart_items.destroy_all
    end
  end

end
