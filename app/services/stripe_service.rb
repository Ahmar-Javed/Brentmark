class StripeService

  def payment_procedure(order)
   @line_items =   order.order_items.includes(:product).map do |item|
          {
            amount: item.product.price.to_i,
            quantity: item.quantity,
            currency: "usd",
            name: item.product.title
          }
        end

    @session = Stripe::checkouts::Session.create({
      payment_method_types: ['card'],
      line_items: @line_items,
      mode: 'payment',
      success_url: 'http://localhost:3000/checkouts',
      cancel_url: 'https://localhost:3000',
    })
  end
end
