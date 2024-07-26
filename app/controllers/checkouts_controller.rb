class CheckoutsController < ApplicationController
  def show
    @session = Stripe::Checkout::Session.create(
      line_items: [{
        price_data: {
          currency: "jpy",
          product_data: {
            name: "yokode_teapot"
          },
          unit_amount: 12345
        },
        quantity: 1
      }],
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

