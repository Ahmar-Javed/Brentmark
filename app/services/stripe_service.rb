class StripeService
  class << self
    include Rails.application.routes.url_helpers

    def payment_procedure(order)
      line_items = order.order_items.includes(:product).map do |item|
        {
          amount: item.product.price.to_i,
          quantity: item.quantity,
          currency: "usd",
          name: item.product.title
        }
      end

      @session = Stripe::Checkout::Session.create(
        {
          payment_method_types: ['card'],
          line_items: line_items,
          mode: 'payment',
          success_url: checkout_url,
          cancel_url: root_url,
        }
      )
    end
  end
end
