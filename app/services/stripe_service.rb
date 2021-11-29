class StripeService

  def initialize(user,final_price)
    @price= final_price
    @user = user
  end

  def payment_procedure(order)
   @line_items =   order.order_items.includes(:product).map do |item|
          {
            amount: item.product.price.to_i,
            quantity: item.quantity,
            currency: "usd",
            name: item.product.title
          }
        end

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: @line_items,
      mode: 'payment',
      success_url: 'http://localhost:3000/checkout',
      cancel_url: 'https://localhost:3000',
    })
  end
end
