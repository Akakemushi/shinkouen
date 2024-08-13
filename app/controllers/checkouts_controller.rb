class CheckoutsController < ApplicationController
  def show
    cart = current_user.cart
    line_item_array = []
    total_cost = 0
    line_items_summary_strings = []
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
      total_cost += teapot.price_cents
      line_items_summary_strings << "sku: #{teapot.sku} maker: #{teapot.maker} price: #{teapot.price_cents}"
    end

    summary_strings = line_items_summary_strings.join(", ")

    @session = Stripe::Checkout::Session.create(
      line_items: line_item_array,
      mode: "payment",
      ui_mode: "embedded",
      return_url: CGI.unescape(payment_url(session_id: '{CHECKOUT_SESSION_ID}'))
    )

    order = current_user.orders.create!(
      stripe_checkout_id: @session.id,
      teapot_sku: summary_strings,
      session_id: @session.id,
      amount_cents: total_cost
    )

    teapots_in_cart.each do |teapot|
      OrderItem.create!(
        order: order,
        teapot: teapot
      )
    end

    cart.cart_items.destroy_all
  end

  private

  def cart
    @cart ||= Cart.includes(cart_items: { teapot: :images }).find(params[:id])
  end
end
