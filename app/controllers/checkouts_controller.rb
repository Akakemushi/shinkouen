class CheckoutsController < ApplicationController
  def show
    cart = current_user.cart
    line_item_array = []
    teapots_in_cart = cart.teapots.includes(:cart_item)
    teapots_in_cart.each do |teapot|
      next_line_item_hash = {
        price_data: {
          currency: "jpy",
          product_data: {
            name: "#{teapot.shape} teapot by #{teapot.maker}"
          },
          unit_amount: teapot.price_cents
        },
        quantity: 1
      }
      line_item_array << next_line_item_hash
    end
    @session = Stripe::Checkout::Session.create(
      line_items: line_item_array,
      mode: "payment",
      ui_mode: "embedded",
      return_url: CGI.unescape(payment_url(session_id: '{CHECKOUT_SESSION_ID}'))
    )

    current_user.orders.create(stripe_checkout_id: @session.id)
  end

  private

  def cart
    @cart ||= Cart.includes(cart_items: { teapot: :images }).find(params[:id])
  end
end
